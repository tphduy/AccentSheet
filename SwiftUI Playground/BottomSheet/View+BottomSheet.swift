//
//  View+BottomSheet.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

extension View {
    /// Presents an bottom sheet when a binding to a `Boolean` value that you provide is true.
    /// - Parameters:
    ///   - isPresented: A binding to a `Boolean` value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - content: A closure that returns the content of the sheet.
    func bottomSheet(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(BottomSheet(isPresented: isPresented, content: content))
    }

    /// Sets the available detents for the enclosing bottom sheet.
    ///
    /// If the new detents don't containt the current detent, the bottom sheet will snap to the first element of new detents or falls back to `.natural` if new detents are empty.
    ///
    /// - Parameters:
    ///   - detents: A list of supported detents for the sheet. If you provide more that one detent, people can drag the sheet to resize it.
    func bottomSheetPresentationDetents(_ detents: [BottomSheetPresentationDetent] = [.natural]) -> some View {
        preference(key: BottomSheetPresentationDetentsKey.self, value: detents)
    }

    /// Conditionally prevents interactive dismissal of a popover or an bottom sheet.
    /// - Parameter isDisabled: A flag that indicates whether to prevent nonprogrammatic dismissal of the containing view hierarchy when presented in an bottom sheet or popover.
    func bottomSheetInteractiveDismissDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: BottomSheetInteractiveDismissDisabledKey.self, value: isDisabled)
    }

    /// Disables the passthrough background that is sandwiched between the presenting view and the bottom sheet to pass through the gesture or dismiss when tapped.
    /// - Parameter isDisabled: A flag that indicates whether the passthrough background is disabled.
    func bottomSheetPresentationPassthroughBackgroundDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: BottomSheetPresentationPassthroughBackgroundDisabledKey.self, value: isDisabled)
    }

    /// Sets the visibility of the drag indicator on top of an bottom sheet.
    /// - Parameter visibility: The preferred visibility of the drag indicator.
    func bottomSheetPresentationDragIndicator(_ visibility: BottomSheetVisibility = .automatic) -> some View {
        preference(key: BottomSheetPresentationDragIndicatorKey.self, value: visibility)
    }

    /// Requests that the presentation have a specific corner radius.
    /// - Parameter cornerRadius: The corner radius, or nil to use the system default.
    func bottomSheetPresentationCornerRadius(_ cornerRadius: CGFloat? = nil) -> some View {
        preference(key: BottomSheetPresentationCornerRadiusKey.self, value: cornerRadius)
    }

    /// Requests that the shadow of presentation have a specific corner radius.
    /// - Parameter cornerRadius: The corner radius, or nil to use the system default. Specifying `0` to disable the shadow.
    func bottomSheetPresentationShadowCornerRadius(_ cornerRadius: CGFloat? = nil) -> some View {
        preference(key: BottomSheetPresentationShadowCornerRadiusKey.self, value: cornerRadius ?? 8)
    }

    /// Enables the shadow of presentation.
    /// - Parameter isEnabled: A flag that indicates whether the shadow is enabled.
    func bottomSheetPresentationShadowEnabled(_ isEnabled: Bool = true) -> some View {
        preference(key: BottomSheetPresentationShadowCornerRadiusKey.self, value: isEnabled ? 8 : 0)
    }
}
