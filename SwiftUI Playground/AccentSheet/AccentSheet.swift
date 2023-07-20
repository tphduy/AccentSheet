//
//  AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 26/06/2023.
//

import SwiftUI

/// A modifier that overlays the original view with a sheet.
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

    /// A flag that indicates whether to prevent nonprogrammatic dismissal of the containing view hierarchy when presented in an accent sheet or popover.
    ///
    /// The default value is `false`.
    @State private var isInteractiveDismissDisabled: Bool = false

    /// A flag that indicates whether the passthrough background is disabled.
    ///
    /// The default value is `false`.
    @State private var isPassthroughBackgroundDisabled: Bool = false

    /// The preferred visibility of the drag indicator.
    ///
    /// The default value is `.automatic`.
    @State private var dragIndicatorVisibility: AccentVisibility = .automatic

    /// The corner radius of the background of the sheet, or nil to use the system default.
    ///
    /// The default value is `8`.
    @State private var backgroundCornerRadius: CGFloat = 8

    /// The corner radius of the shadow of the sheet, or nil to use the system default.
    ///
    /// The default value is `0`.
    @State private var shadowCornerRadius: CGFloat = 0

    /// The self-sizing size of the sheet.
    ///
    /// The default value is `.zero`.
    @State private var sheetSize: CGSize = .zero

    /// The total translation from the start of the drag gesture to the current event of the drag gesture and resets the property back to its initial state when the gesture ends.
    ///
    /// The default value is `.zero`.
    @GestureState private var translation: CGSize = .zero

    /// A binding value that determines whether to present the sheet that you create in the modifier’s content closure.
    @Binding private var isPresented: Bool

    /// A closure that returns the content of the sheet.
    private let sheet: () -> Sheet

    // MARK: Init

    /// A modifier that overlays the original view with a sheet.
    /// - Parameters:
    ///   - isPresented: A binding value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - sheet: A closure that returns the content of the sheet.
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Sheet = EmptyView.init
    ) {
        self.sheet = content
        self._isPresented = isPresented
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        ZStack {
            // The underlying content.
            content

            if isPresented {
                // A view between the presenting view and the sheet to pass through the gesture or dismiss when tapped.
                if !isPassthroughBackgroundDisabled {
                     passthroughBackground
                }

                // Reads The available space.
                GeometryReader { (geometry: GeometryProxy) in
                    let offset =  offset(in: geometry)
                    // The self sizing sheet.
                    VStack {
                        if isDragIndicatorEnabled {
                            dragIndicator
                        }
                        // Clips the content to avoid it spreading over the parent bounds.
                        // Example: if `sheet()` is a list and the translation reached over the top safe area inset, the list frame will spread over the parent bounds
                        if #available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *) {
                            sheet()
                                .scrollDisabled(offset.height > 0)
                                .clipped()
                        } else {
                            sheet()
                                .clipped()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        GeometryReader { (sheetGeometry: GeometryProxy) in
                            RoundedRectangle(cornerRadius: backgroundCornerRadius)
                                .fill(Color.white)
                                .ignoresSafeArea(edges: [.bottom, .horizontal])
                                // The background always covers the bottom/horizontal safe area.
                                .frame(height: geometry.size.height - translation.height)
                                // Reads the natural size of the sheet.
                                .onAppear {
                                    sheetSize = sheetGeometry.size
                                }
                        }
                    )
                    .compositingGroup()
                    .shadow(radius: shadowCornerRadius)
                    .offset(offset)
                    .gesture(dragGesture(in: geometry))
                    .animation(.spring(), value: offset)
                    .transition(.move(edge: .bottom))
                    .onPreferenceChange(AccentPresentationDetentsKey.self, perform: onDetentsChanged(_:))
                    .onPreferenceChange(AccentInteractiveDismissDisabledKey.self) { newValue in
                        isInteractiveDismissDisabled = newValue
                    }
                    .onPreferenceChange(AccentPresentationPassthroughBackgroundDisabledKey.self) { newValue in
                        isPassthroughBackgroundDisabled = newValue
                    }
                    .onPreferenceChange(AccentPresentationDragIndicatorKey.self) { newValue in
                        dragIndicatorVisibility = newValue
                    }
                    .onPreferenceChange(AccentPresentationCornerRadiusKey.self) { newValue in
                        backgroundCornerRadius = newValue ?? 8
                    }
                    .onPreferenceChange(AccentPresentationShadowCornerRadiusKey.self) { newValue in
                        shadowCornerRadius = newValue
                    }
                }
            }
        }
    }

    // MARK: Preferences

    /// Accepts a new value of available detents and validate the current detent.
    ///
    /// If the current detent is invalid, the sheet will snap to the first element of new detents or falls back to `.natural` if new detents are empty.
    ///
    /// - Parameter newValue: The available detents where the sheet may naturally rests.
    private func onDetentsChanged(_ newValue: [AccentPresentationDetent]) {
        // Saves the new value.
        detents = Set(newValue)
        // Determines whether the current detent is invalid.
        guard !newValue.contains(currentDetent) else { return }
        // Snaps to the first available detent or falls back to `.natural` if the available detents are empty.
        currentDetent = newValue.first ?? .natural
    }

    // MARK: Utilities

    /// A dragging motion that resizes the sheet.
    private func dragGesture(in geometry: GeometryProxy) -> some Gesture {
        DragGesture()
            .updating($translation) { (value: DragGesture.Value, state: inout CGSize, _: inout Transaction) in
                // Saves the translatio to offset the sheet.
                state = value.translation
                // Not setting an animation to the `transaction` because it just animate while dragging.
                // transaction.animation = .spring()
            }
            .onEnded { (value: DragGesture.Value) in
                // Calculates the predicted offset on drag gesture ended.
                let offset = offset(for: currentDetent, with: value.translation, in: geometry)
                // Verifies the most potential detent with the predicted offset is some.
                guard let potentialDetent = potentialDetent(for: offset, in: geometry) else { return }
                // Snaps the sheet to potential detent.
                defer { currentDetent = potentialDetent }
                // Verifies the interactive dismiss is enabled.
                guard !isInteractiveDismissDisabled else { return }
                // Verifies the translation reached the threshold to dismiss.
                guard value.translation.height / geometry.size.height >= 0.2 else { return }
                // Verifies the current detent is the shortest to dismiss.
                guard currentDetent == shortestDetent(in: geometry) else { return }
                // Dismisses the sheet.
                isPresented = false
            }
    }

    /// A view is sandwiched between the presenting view and the sheet to pass through the gesture or dismiss when tapped.
    private var passthroughBackground: some View {
        Color(red: 0.93, green: 0.93, blue: 1)
            .opacity(0.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .allowsHitTesting(false)
    }

    /// A view that indicates the sheet can resize or dismiss interactively.
    private var dragIndicator: some View {
        Capsule()
            .fill(Color.gray)
            .frame(width: 36, height: 5)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }

    /// Returns a flag that indicates whether the drag indicator is enabled.
    private var isDragIndicatorEnabled: Bool {
        switch dragIndicatorVisibility {
        case .automatic where detents.count > 1, .visible:
            return true
        default:
            return false
        }
    }

    /// Combines the spacing of the current detent with the current translation of a drag gesture to offset of the sheet.
    /// - Parameter geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: A size whose the amount of width is always `0`, height is the combination of the spacing of the current detent with the current translation of a drag gesture.
    private func offset(in geometry: GeometryProxy) -> CGSize {
        offset(for: currentDetent, with: translation, in: geometry)
    }

    /// Combines the spacing of a detent with the translation of a drag gesture to offset of the sheet.
    /// - Parameters:
    ///   - detent: A type that represents a height where a sheet naturally rests.
    ///   - translation: The total translation from the start of the drag gesture to the current event of the drag gesture.
    ///   - geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: A size whose the amount of width is always `0`, height is the combination of the spacing of a detent with the translation of a drag gesture.
    private func offset(
        for detent: AccentPresentationDetent,
        with translation: CGSize,
        in geometry: GeometryProxy
    ) -> CGSize {
        CGSize(
            width: 0,
            height: spacing(for: detent, in: geometry) + translation.height
        )
    }

    /// The spacing from top of the sheet for a detent without the translation of a drag gesture.
    /// - Parameters:
    ///   - detent: A type that represents a height where a sheet naturally rests.
    ///   - geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: The spacing from top of the sheet.
    private func spacing(for detent: AccentPresentationDetent, in geometry: GeometryProxy) -> CGFloat {
        let available = geometry.size.height - geometry.safeAreaInsets.bottom
        switch detent {
        case .natural:
            return available - sheetSize.height
        case .medium:
            return available / 2
        case .large:
            return 0
        case .fraction(let fraction):
            return available * (1 - fraction)
        case .height(let height):
            return available - height
        }
    }

    /// A collection whose value is the spacing without translation of the sheet for each available detent.
    ///
    /// If more than one detents have the same spacing, they will be filter from the result.
    private func spacingPerDetent(in geometry: GeometryProxy) -> [AccentPresentationDetent: CGFloat] {
        detents.reduce(into: [:]) { (result: inout [AccentPresentationDetent: CGFloat], detent: AccentPresentationDetent) in
            // Calculates the spacing for the this detent.
            let spacing = spacing(for: detent, in: geometry)
            // Determines the result dictionary doesn't have any element whose value is the same.
            guard !result.values.contains(spacing) else { return }
            // Appends the spacing to the result.
            result[detent] = spacing
        }
    }

    /// Returns the most potential detent (the nearest) for a predicted offset of the sheet.
    /// - Parameters:
    ///   - offset: A prediction, based on the drag gesture, of the amount to offset the sheet.
    ///   - geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: A detent if the available detents are not empty.
    private func potentialDetent(for offset: CGSize, in geometry: GeometryProxy) -> AccentPresentationDetent? {
        spacingPerDetent(in: geometry).min { lhs, rhs in
            abs(lhs.value - offset.height) < abs(rhs.value - offset.height)
        }?.key
    }

    /// Returns a detent that reduces the height of the sheet to the shortest when snaps to it
    /// - Parameter geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: A detent if the available detents are not empty.
    private func shortestDetent(in geometry: GeometryProxy) -> AccentPresentationDetent? {
        spacingPerDetent(in: geometry).max { lhs, rhs in
            lhs.value < rhs.value
        }?.key
    }
}

struct AccentSheet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            staticContent
                .previewDisplayName("Static")
            scrollableContent
                .previewDisplayName("Scrollable")
        }
    }

    static private var staticContent: some View {
        NavigationView {
            Text("Content")
                .navigationTitle("Accent Sheet")
                .accentSheet(isPresented: .constant(true)) {
                    LicenseAgreement()
                        .padding()
                        .accentPresentationDetents([.natural, .large])
                }
        }
    }

    static private var scrollableContent: some View {
        NavigationView {
            Text("Content")
                .navigationTitle("Accent Sheet")
                .accentSheet(isPresented: .constant(true)) {
                    Numbers()
                        .accentPresentationDetents([.fraction(0.2), .medium, .large])
                }
        }
    }
}
