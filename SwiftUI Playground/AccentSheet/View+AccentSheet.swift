//
//  View+AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

extension View {
    /// Presents an accent sheet when a binding to a `Boolean` value that you provide is true.
    /// - Parameters:
    ///   - isPresented: A binding to a `Boolean` value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - content: A closure that returns the content of the sheet.
    func accentSheet(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(AccentSheet(isPresented: isPresented, content: content))
    }

    /// Sets the available detents for the enclosing accent sheet.
    ///
    /// If the new detents don't containt the current detent, the accent sheet will snap to the first element of new detents or falls back to `.natural` if new detents are empty.
    ///
    /// - Parameters:
    ///   - detents: A list of supported detents for the sheet. If you provide more that one detent, people can drag the sheet to resize it.
    func accentPresentationDetents(_ detents: [AccentPresentationDetent] = [.natural]) -> some View {
        preference(key: AccentPresentationDetentsKey.self, value: detents)
    }

    /// Conditionally prevents interactive dismissal of a popover or an accent sheet.
    /// - Parameter isDisabled: A flag that indicates whether to prevent nonprogrammatic dismissal of the containing view hierarchy when presented in an accent sheet or popover.
    func accentInteractiveDismissDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: AccentInteractiveDismissDisabledKey.self, value: isDisabled)
    }

    /// Disables the passthrough background that is sandwiched between the presenting view and the accent sheet to pass through the gesture or dismiss when tapped.
    /// - Parameter isDisabled: A flag that indicates whether the passthrough background is disabled.
    func accentPresentationPassthroughBackgroundDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: AccentPresentationPassthroughBackgroundDisabledKey.self, value: isDisabled)
    }

    /// Sets the visibility of the drag indicator on top of an accent sheet.
    /// - Parameter visibility: The preferred visibility of the drag indicator.
    func accentPresentationDragIndicator(_ visibility: AccentVisibility = .automatic) -> some View {
        preference(key: AccentPresentationDragIndicatorKey.self, value: visibility)
    }

    /// Requests that the presentation have a specific corner radius.
    /// - Parameter cornerRadius: The corner radius, or nil to use the system default.
    func accentPresentationCornerRadius(_ cornerRadius: CGFloat? = nil) -> some View {
        preference(key: AccentPresentationCornerRadiusKey.self, value: cornerRadius)
    }

    /// Requests that the shadow of presentation have a specific corner radius.
    /// - Parameter cornerRadius: The corner radius, or nil to use the system default. Specifying `0` to disable the shadow.
    func accentPresentationShadowCornerRadius(_ cornerRadius: CGFloat? = nil) -> some View {
        preference(key: AccentPresentationShadowCornerRadiusKey.self, value: cornerRadius ?? 8)
    }

    /// Enables the shadow of presentation.
    /// - Parameter isEnabled: A flag that indicates whether the shadow is enabled.
    func accentPresentationShadowEnabled(_ isEnabled: Bool = true) -> some View {
        preference(key: AccentPresentationShadowCornerRadiusKey.self, value: isEnabled ? 8 : 0)
    }
}
