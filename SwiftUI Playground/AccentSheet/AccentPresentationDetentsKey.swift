//
//  AccentPresentationDetentsKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

struct AccentPresentationDetentsKey: PreferenceKey {
    static var defaultValue: [AccentPresentationDetent] {
        [.natural]
    }

    static func reduce(value: inout [AccentPresentationDetent], nextValue: () -> [AccentPresentationDetent]) {
        value = nextValue()
    }
}
