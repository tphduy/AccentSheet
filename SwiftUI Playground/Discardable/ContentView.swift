//
//  ContentView.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    private enum CoordinateSpaces {
        case scrollView
    }
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ParallaxHeader(
                    coordinateSpace: CoordinateSpaces.scrollView,
                    defaultHeight: 400
                ) {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                }

                Rectangle()
                    .fill(.blue)
                    .frame(height: UIScreen.main.bounds.height)
                    .shadow(radius: 2)
            }
        }
        .coordinateSpace(name: CoordinateSpaces.scrollView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
