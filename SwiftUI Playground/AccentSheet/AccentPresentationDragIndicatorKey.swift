//
//  AccentPresentationDragIndicatorKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

struct AccentPresentationDragIndicatorKey: PreferenceKey {
    static var defaultValue: AccentVisibility {
        .automatic
    }

    static func reduce(value: inout AccentVisibility, nextValue: () -> AccentVisibility) {
        value = nextValue()
    }
}
