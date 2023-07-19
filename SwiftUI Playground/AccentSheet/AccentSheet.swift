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

    /// The curent detent where the sheet naturally rests.
    ///
    /// The default value is `.natural`.
    @State private var currentDetent: AccentPresentationDetent = .natural

    /// The potential detents where the sheet may naturally rests.
    ///
    /// The default value is `[.natural]`.
    @State private var detents: Set<AccentPresentationDetent> = Set([.natural])

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

    @State private var configuration: AccentPresentationConfiguration = AccentPresentationConfiguration()

    /// A binding value that determines whether to present the sheet that you create in the modifier’s content closure.
    @Binding private var isPresented: Bool

    private let sheet: () -> Sheet

    // MARK: Init

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: @escaping () -> Sheet = EmptyView.init
    ) {
        self.sheet = sheet
        self._isPresented = isPresented
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        ZStack {
            // A wrapper view to center the presenting view.
            content

            // A view between the presenting view and the sheet to pass through the gesture or dismiss when tapped.
            if configuration.isPassthroughtBackgroundEnabled {
                passthroughtBackground
            }

            // The presented sheet.
            if isPresented {
                container
                    .background(sheetBackground)
                    .compositingGroup()
                    .shadow(radius: configuration.cornerRadius)
                    .offset(offset)
                    .gesture(dragGesture)
                    .animation(.spring(), value: offset)
                    .onPreferenceChange(AccentPresentationDetentsKey.self, perform: onDetentsChanged(_:))
                    .onPreferenceChange(AccentPresentationConfigurationKey.self, perform: onConfigurationChanged(_:))
            }
        }
    }

    // MARK: Preferences

    /// Accepts a new value of available detents and validate the current detent.
    ///
    /// If the current detent is invalid, the sheet will snap to the first element of new detents or falls back to `.natural` if new detents are empty.
    ///
    /// - Parameter newValue: The potential detents where the sheet may naturally rests.
    private func onDetentsChanged(_ newValue: [AccentPresentationDetent]) {
        // Saves the new value.
        detents = Set(newValue)
        // Determines whether the current detent is invalid.
        guard !newValue.contains(currentDetent) else { return }
        // Snaps to the first available detent or falls back to `.natural` if the available detents are empty.
        currentDetent = newValue.first ?? .natural
    }

    /// Accepts a new value of configuration.
    /// - Parameter newValue:
    private func onConfigurationChanged(_ newValue: AccentPresentationConfiguration) {
        configuration = newValue
    }

    // MARK: Utilities

    private var container: some View {
        // The container that takes all available space.
        ZStack {
            // The actual self-sizing sheet.
            VStack(spacing: configuration.spacing) {
                dragIndicator
                sheet()
            }
            .frame(maxWidth: .infinity)
            // Reads the natural size of the sheet.
            .background(sizeReader(size: $sheetSize))
            // Take available space to align the other contents on top.
            Spacer()
        }
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
                let offset = offset(for: currentDetent, with: value.translation)
                // Determines the most matched detent with the predicted offset.
                guard let detent = detent(for: offset) else { return }
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

    private var offset: CGSize {
        offset(for: currentDetent, with: translation)
    }

    private func offset(for detent: AccentPresentationDetent, with translation: CGSize) -> CGSize {
        CGSize(
            width: 0,
            height: spacing(for: detent) + translation.height
        )
    }

    private func spacing(for detent: AccentPresentationDetent) -> CGFloat {
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

    /// A collection whose value is the default spacing of the sheet for each available detent.
    ///
    /// If more than one detents have the same spacing, they will be filter from the result.
    private var spacingPerDetent: [AccentPresentationDetent: CGFloat] {
        detents.reduce(into: [:]) { (result: inout [AccentPresentationDetent: CGFloat], detent: AccentPresentationDetent) in
            // Calculates the spacing for the this detent.
            let spacing = spacing(for: detent)
            // Determines the result dictionary doesn't have any element whose value is the same.
            guard !result.values.contains(spacing) else { return }
            // Appends the spacing to the result.
            result[detent] = spacing
        }
    }

    /// Finds the most potential detent for a predicted offset of the sheet.
    /// - Parameter offset: A prediction, based on the drag gesture, of the amount to offset the sheet.
    /// - Returns: The most potential detent.
    private func detent(for offset: CGSize) -> AccentPresentationDetent? {
        spacingPerDetent.min { lhs, rhs in
            abs(lhs.value - offset.height) < abs(rhs.value - offset.height)
        }?.key
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
                    .accentPresentationDetents([.height(100), .medium, .large])
                }
        }
    }
}
