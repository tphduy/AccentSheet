//
//  AccentPresentationPassthroughtBackgroundKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

struct AccentPresentationPassthroughtBackgroundKey: PreferenceKey {
    static var defaultValue: AccentVisibility {
        .automatic
    }

    static func reduce(value: inout AccentVisibility, nextValue: () -> AccentVisibility) {
        value = nextValue()
    }
}
