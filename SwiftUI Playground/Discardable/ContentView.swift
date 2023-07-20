//
//  ContentView.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    @State private var isLoggedIn = false

    var body: some View {
        if #available(iOS 16.0, *) {
            Button("Content") {
                isPresented.toggle()
            }
            .navigationTitle("Accent Sheet")
            .toolbar {
                ToolbarItem {
                    Button("Toggle") {
                        isPresented.toggle()
                    }
                }
            }
            .accentSheet(isPresented: $isPresented) {
                LicenseAgreement()
                    .padding()
                    .accentPresentationDetents([.natural, .large])
            }
//            .sheet(isPresented: $isPresented) {
//                LicenseAgreement()
//                    .padding()
//                    .presentationDetents([.medium, .large])
//            }
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
