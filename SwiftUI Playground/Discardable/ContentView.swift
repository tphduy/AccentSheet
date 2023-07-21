//
//  ContentView.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI


struct ContentView: View {
    @State private var isPresented = true

    @State private var isAuthorized = false

    var body: some View {
        if #available(iOS 16.0, *) {
            Text("Content")
                .navigationTitle("Bottom Sheet")
                .toolbar {
                    ToolbarItem {
                        Toggle(
                            isPresented ? "Hide" : "Show",
                            isOn: $isPresented
                        )
                    }

                    ToolbarItem {
                        Toggle(
                            isAuthorized ? "Deny License" : "Accept License",
                            isOn: $isAuthorized
                        )
                    }
                }
                .bottomSheet(isPresented: $isPresented, content: sheetContent)
        }
    }

    private func sheetContent() -> some View {
        LicenseAgreement(onAgree: {
            isAuthorized = true
        })
        .padding()
        .bottomSheetPresentationDetents([.natural, .medium, .large])
        .bottomSheetInteractiveDismissDisabled()
        .bottomSheetPresentationDragIndicator()
        .bottomSheetPresentationCornerRadius(16)
        .bottomSheetPresentationShadowCornerRadius()
        .bottomSheetPresentationPassthroughBackgroundDisabled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
