//
//  ContentView.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Text("Content")
            .navigationTitle("Accent Sheet")
            .toolbar {
                ToolbarItem {
                    Button("Toggle") {
                        isPresented.toggle()
                    }
                }
            }
            .accentSheet(isPresented: $isPresented) {
                VStack(spacing: 16) {
                    Text("Lorem Ipsum")
                        .font(.title)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                }
                .padding()
                .accentPresentationDetents([.natural, .large])
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
