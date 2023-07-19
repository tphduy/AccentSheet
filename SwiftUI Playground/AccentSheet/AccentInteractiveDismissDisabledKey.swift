//
//  InteractiveDismissDisabledKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

struct AccentInteractiveDismissDisabledKey: PreferenceKey {
    static var defaultValue: Bool {
        true
    }

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
