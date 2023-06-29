//
//  AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 26/06/2023.
//

import SwiftUI

public struct AccentSheet<SheetHeader, SheetContent>: ViewModifier where SheetHeader: View, SheetContent: View {
    // MARK: States

    @Binding public var isPresented: Bool

    public let configuration: AccentSheetConfiguration

    public let sheetHeader: SheetHeader

    public let sheetContent: SheetContent

    // MARK: ViewModifier

    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            ZStack{
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if isPresented {
                shadowedSheet
                    .transition(.move(edge: .bottom))
                    .animation(.default)
            }
        }
    }

    // MARK: Utilities

    private var dragIndicator: some View {
        Capsule()
            .fill(Color.gray)
            .frame(width: 36, height: 5)
            .padding()
    }

    private var sheet: some View {
        VStack(spacing: configuration.spacing) {
            dragIndicator
            sheetHeader
            sheetContent
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: configuration.cornerRadius)
                .fill(Color.white)
                .ignoresSafeArea(edges: [.bottom, .horizontal])
        )
        .compositingGroup()
    }

    @ViewBuilder private var shadowedSheet: some View {
        if configuration.isShadowEnabled {
            sheet.shadow(radius: configuration.cornerRadius)
        } else {
            sheet
        }
    }
}

struct AccentSheet_Previews: PreviewProvider {
    static func sheet(isPresented: Bool) -> some View {
        Button("Foo") {}
            .padding()
            .accentSheet(isPresented: .constant(isPresented)) {
                Text("Header")
            } content: {
                Text("Content")
            }
    }

    static var previews: some View {
        Group {
            sheet(isPresented: true)
                .previewDisplayName("Showed")

            sheet(isPresented: false)
                .previewDisplayName("Hidden")
        }
    }
}
