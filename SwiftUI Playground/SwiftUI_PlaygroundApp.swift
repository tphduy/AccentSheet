//
//  SwiftUI_PlaygroundApp.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 25/05/2023.
//

import SwiftUI

@main
struct SwiftUI_PlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
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
}
