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

    /// Sets the configuration to an accent sheet.
    /// - Parameter newValue: A group of properties to configure the accent sheet.
    func accentPresentationConfiguration(_ newValue: AccentPresentationConfiguration) -> some View {
        preference(key: AccentPresentationConfigurationKey.self, value: newValue)
    }

    /// Sets the available detents for the enclosing accent sheet.
    ///
    /// If the new detents don't containt the current detent, the accent sheet will snap to the first element of new detents or falls back to `.natural` if new detents are empty.
    ///
    /// - Parameters:
    ///   - detents: A list of supported detents for the sheet. If you provide more that one detent, people can drag the sheet to resize it.
    func accentPresentationDetents(_ newValue: [AccentPresentationDetent] = [.natural]) -> some View {
        preference(key: AccentPresentationDetentsKey.self, value: newValue)
    }

    /// Conditionally prevents interactive dismissal of a popover or an accent sheet.
    /// - Parameter isDisabled: A flag that indicates whether to prevent nonprogrammatic dismissal of the containing view hierarchy when presented in an accent sheet or popover.
    func accentInteractiveDismissDisabled(_ isDisabled: Bool = true) -> some View {
        Text("Not implemented")
    }

    /// Sets the visibility of the drag indicator on top of an accent sheet.
    func accentPresentationDragIndicator(_ visibility: AccentVisibility) -> some View {
        Text("Not implemented")
    }

    /// Requests that the presentation have a specific corner radius.
    /// - Parameter cornerRadius: The corner radius, or nil to use the system default.
    func accentPresentationCornerRadius(_ cornerRadius: CGFloat?) -> some View {
        Text("Not implemented")
    }
}
