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
                ToolbarItem(placement: .navigationBarLeading) {
                    Toggle("Toggle Bottom Sheet", isOn: $isPresented)
                }
            }
            .accentSheet(isPresented: $isPresented) {
                VStack(spacing: 16) {
                    Text("Lorem Ipsum")
                        .font(.title)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                }
                .padding()
                .accentPresentationDetents([.height(100), .natural, .large])
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
