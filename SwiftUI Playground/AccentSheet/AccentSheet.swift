//
//  AccentSheet.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 26/06/2023.
//

import SwiftUI

public struct AccentSheet<SheetHeader, SheetContent>: ViewModifier where SheetHeader: View, SheetContent: View {
    // MARK: States

    @Binding var isPresented: Bool

    @State var detent: AccentPresentationDentent = .natural

    @GestureState var offset: CGSize = .zero

    let configuration: AccentSheetConfiguration

    let sheetHeader: SheetHeader

    let sheetContent: SheetContent

    // MARK: ViewModifier

    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            ZStack {
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if isPresented {
                draggableSheet
            }
        }

    }

    // MARK: Utilities

    private var dragIndicator: some View {
        Capsule()
            .fill(Color.gray)
            .frame(width: 36, height: 5)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($offset) { value, state, _ in
                state = CGSize(width: 0, height: value.translation.height)
            }
            .onEnded { (value: DragGesture.Value) in
                // Snap to an available detent if needed.
            }
    }

    @ViewBuilder private var draggableSheet: some View {
        VStack(alignment: configuration.alignment, spacing: configuration.spacing) {
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
        .shadow(radius: configuration.cornerRadius)
        .offset(offset)
        .gesture(dragGesture)
        .animation(
            .interpolatingSpring(
                mass: 1.2,
                stiffness: 200,
                damping: 25
            )
        )
        .transition(.move(edge: .bottom))
    }
}

struct AccentSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("Foo Bar")
                .navigationTitle("Lorem Ipsum")
                .accentSheet(isPresented: .constant(true)) {
                    Text("Header")
                } content: {
                    Text("Content")
                }
        }
    }
}
