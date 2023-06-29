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
        @ViewBuilder header: @escaping () -> some View = EmptyView.init,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(
            AccentSheet(
                isPresented: isPresented,
                configuration: configuration,
                sheetHeader: header(),
                sheetContent: content()
            )
        )
    }
}
