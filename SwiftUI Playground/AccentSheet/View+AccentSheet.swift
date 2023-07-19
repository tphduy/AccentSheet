//
//  View+AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

extension View {
    func accentSheet(
        isPresented: Binding<Bool>,
        @ViewBuilder sheet: @escaping () -> some View
    ) -> some View {
        modifier(AccentSheet(isPresented: isPresented, sheet: sheet))
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

    func accentPresentationConfiguration(_ newValue: AccentPresentationConfiguration) -> some View {
        preference(key: AccentPresentationConfigurationKey.self, value: newValue)
    }
}
