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
        configuration: AccentSheetConfiguration = AccentSheetConfiguration(),
        @ViewBuilder sheet: @escaping () -> some View
    ) -> some View {
        modifier(
            AccentSheet(
                isPresented: isPresented,
                configuration: configuration,
                sheet: sheet
            )
        )
    }

    func accentPresentationDetents(
        _ detents: Set<AccentPresentationDentent> = [.natural],
        selection: ((AccentPresentationDentent) -> Void)? = nil
    ) -> some View {
        preference(key: AccentPresentationDetentsKey.self, value: detents)
    }
}
