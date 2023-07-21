//
//  ContentView.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

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
                .bottomSheet(isPresented: $isPresented) {
                    if isAuthorized {
                        Numbers()
                            .bottomSheetPresentationDetents([.fraction(0.2), .medium, .large])
                            .bottomSheetPresentationCornerRadius(0)
                    } else {
                        LicenseAgreement(onAgree: {
                            isAuthorized = true
                        })
                        .padding()
                        .bottomSheetPresentationDetents([.natural])
                        .bottomSheetPresentationShadowEnabled()
                        .bottomSheetInteractiveDismissDisabled()
                    }
                }
//                .sheet(isPresented: $isPresented) {
//                    LicenseAgreement(onAgree: {
//                        isAuthorized = true
//                    })
//                    .padding()
//                    .presentationDetents([.medium, .large])
//                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
