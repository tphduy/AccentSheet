//
//  Numbers.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

struct Numbers: View {
    var body: some View {
        VStack {
            Text("List")
                .font(.headline)

            List(0...100, id: \.self) { (number: Int) in
                Text("\(number)")
            }
            .listStyle(.plain)
        }
    }
}

struct Numbers_Previews: PreviewProvider {
    static var previews: some View {
        Numbers()
    }
}
