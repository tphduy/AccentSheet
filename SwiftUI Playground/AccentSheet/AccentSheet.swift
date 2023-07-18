//
//  AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 26/06/2023.
//

import SwiftUI
import OSLog

struct AccentSheet<Sheet>: ViewModifier where Sheet: View {
    // MARK: States

    /// A binding value that determines whether to present the sheet that you create in the modifier’s content closure.
    @Binding private var isPresented: Bool

    /// The curent detent where the sheet naturally rests.
    ///
    /// The default value is `.natural`.
    @State private var currentDetent: AccentPresentationDentent = .natural

    /// The potential detents where the sheet may naturally rests.
    ///
    /// The default value is `[.natural]`.
    @State private var potentialDetents: Set<AccentPresentationDentent> = Set([.natural])

    /// The self-sizing size of the sheet.
    ///
    /// The default value is `.zero`.
    @State private var sheetSize: CGSize = .zero

    /// The self-sizing size of the sheet container.
    ///
    /// The default value is `.zero`.
    @State private var containerSize: CGSize = .zero

    /// The total translation from the start of the drag gesture to the current event of the drag gesture and resets the property back to its initial state when the gesture ends
    ///
    /// The default value is `.zero`.
    @GestureState private var translation: CGSize = .zero

    private let configuration: AccentSheetConfiguration

    private let sheet: () -> Sheet

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: "\(Self.self)"
    )

    // MARK: Init

    init(
        isPresented: Binding<Bool>,
        configuration: AccentSheetConfiguration = AccentSheetConfiguration(),
        @ViewBuilder sheet: @escaping () -> Sheet = EmptyView.init
    ) {
        self.configuration = configuration
        self.sheet = sheet
        self._isPresented = isPresented
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        ZStack {
            // A wrapper view to center the presenting view.
            content

            // A view between the presenting view and the sheet to pass through the gesture or dismiss when tapped.
            // passthroughtBackground

            // The presented sheet.
            if isPresented {
                container
                    .edgesIgnoringSafeArea(configuration.edgesIgnoringSafeArea)
                    .background(sheetBackground)
                    .compositingGroup()
                    .shadow(radius: configuration.cornerRadius)
                    .offset(offset)
                    .gesture(dragGesture)
                    .animation(.spring(), value: offset)
                    .onPreferenceChange(AccentPresentationDetentsKey.self, perform: onDetentsChanged(_:))
            }
        }
    }

    // MARK: Preferences

    /// Accepts the new value of potential detents and validates if the current detent is still valid.
    ///
    /// If the current detent is invalid, the sheet will snap to first potential detent of `.natural` if the new potential detents are empty.
    ///
    /// - Parameter newValue: The potential detents where the sheet may naturally rests.
    private func onDetentsChanged(_ newValue: Set<AccentPresentationDentent>) {
        // Saves the new value.
        potentialDetents = newValue
        // Determines whether the current detent is invalid.
        guard !newValue.contains(currentDetent) else { return }
        // Snaps the current detent to the first value of the potential detents or falls back to the natural detent if empty.
        currentDetent = newValue.first ?? .natural
    }

    // MARK: Utilities

    private var container: some View {
        // The container that takes all available space.
        ZStack {
            // The actual self-sizing sheet.
            VStack(alignment: configuration.alignment, spacing: configuration.spacing) {
                // The drag indicator is always center.
                HStack {
                    Spacer()
                    dragIndicator
                    Spacer()
                }
                // The content of the sheet.
                sheet()
            }
            .frame(maxWidth: .infinity)
            // Reads the natural size of the sheet.
            .background(sizeReader(size: $sheetSize))
            // Take available space to align the other contents on top.
            Spacer()
        }
    }

    private var dragIndicatorSize: CGSize {
        CGSize(width: 36, height: 5)
    }

    private var dragIndicatorEdgeInsets: EdgeInsets {
        EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    }

    /// A view that indicates the sheet can resize or dismiss interactively.
    private var dragIndicator: some View {
        Capsule()
            .fill(Color.gray)
            .frame(width: dragIndicatorSize.width, height: dragIndicatorSize.height)
            .padding(dragIndicatorEdgeInsets)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($translation) { (value: DragGesture.Value, state: inout CGSize, transaction: inout Transaction) in
                // Saves the translatio to offset the sheet.
                state = value.translation
                // Not setting an animation to the `transaction` because it just animate while dragging.
                // transaction.animation = .spring()
            }
            .onEnded { (value: DragGesture.Value) in
                // Calculates the predicted offset on drag gesture ended.
                let predictedOffset = spacing + value.translation.height
                // Determines the most matched detent with the predicted offset and it's different from the current detent.
                guard let detent = potentialDetent(for: predictedOffset), currentDetent != detent else { return }
                // Snaps the sheet to potential detent.
                currentDetent = detent
            }
    }

    private var passthroughtBackground: some View {
        Color.black
            .opacity(0.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .contentShape(Rectangle())
    }

    private var sheetBackground: some View {
        // Reads the natural size of the sheet container.
        sizeReader(size: $containerSize) {
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                .fill(Color.white)
                .edgesIgnoringSafeArea([.bottom, .horizontal])
        }
    }

    private var offset: CGSize {
        CGSize(width: 0, height: spacing + translation.height)
    }

    private var spacing: CGFloat {
        spacing(for: currentDetent)
    }

    private func spacing(for detent: AccentPresentationDentent) -> CGFloat {
        switch detent {
        case .natural:
            return containerSize.height - sheetSize.height
        case .medium:
            return containerSize.height / 2
        case .large:
            return 0
        case .fraction(let fraction):
            return containerSize.height * (1 - fraction)
        case .height(let height):
            return containerSize.height - height
        }
    }

    /// A collection whose value is the default spacing of the sheet for each potential presentation detent.
    ///
    /// If more than one presentation detents have the same spacing, they will be filter from the result.
    private var defaultSpacingPerDetent: [AccentPresentationDentent: CGFloat] {
        potentialDetents.reduce(into: [:]) { (result: inout [AccentPresentationDentent: CGFloat], detent: AccentPresentationDentent) in
            // Calculates the spacing for the this detent.
            let candidate = spacing(for: detent)
            // Determines the result dictionary doesn't have any element whose value is the same.
            guard !result.values.contains(candidate) else { return }
            // Appends the spacing to the result.
            result[detent] = candidate
        }
    }

    /// Finds the most potential detent for a predicted offset of the sheet.
    /// - Parameter offset: A prediction, based on the drag gesture, of the amount to offset the sheet.
    /// - Returns: The most potential detent.
    private func potentialDetent(for offset: CGFloat) -> AccentPresentationDentent? {
        defaultSpacingPerDetent
            .min { lhs, rhs in
                abs(lhs.value - offset) < abs(rhs.value - offset)
            }?.key
    }

    /// A transparent view to retrive the size of the sheet.
    private func sizeReader(
        size: Binding<CGSize>,
        _ background: @escaping () -> some View =  { Color.clear }
    ) -> some View {
        GeometryReader { (geometry: GeometryProxy) in
            background().onAppear {
                size.wrappedValue = geometry.size
            }
        }
    }
}

struct AccentSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccentSheetWrapper()
        }
    }

    private struct AccentSheetWrapper: View {
        @State private var isPresented = true

        var body: some View {
            Text("Content")
                .navigationTitle("Accent Sheet")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Toggle("Toggle Bottom Sheet", isOn: $isPresented)
                    }
                }
                .accentSheet(isPresented: $isPresented) {
                    List {
                        Section {
                            ForEach(0...100, id: \.self) { (number: Int) in
                                Text("\(number)")
                            }
                        } header: {
                            Text("Header")
                                .frame(maxWidth: .infinity)
                                .font(.title)
                                .background(Color.red.opacity(0.5))
                        }
                    }
                    .listStyle(.plain)
                    .accentPresentationDetents([.medium, .large])
                }
        }
    }
}
