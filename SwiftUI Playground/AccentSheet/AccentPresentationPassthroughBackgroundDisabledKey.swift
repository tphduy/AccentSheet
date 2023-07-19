//
//  AccentPresentationPassthroughBackgroundDisabledKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

struct AccentPresentationPassthroughBackgroundDisabledKey: PreferenceKey {
    static var defaultValue: Bool {
        false
    }

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
