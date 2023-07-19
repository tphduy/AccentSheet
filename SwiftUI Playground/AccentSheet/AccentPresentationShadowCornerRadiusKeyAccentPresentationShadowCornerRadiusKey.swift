//
//  AccentPresentationShadowCornerRadiusKey.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

struct AccentPresentationShadowCornerRadiusKey: PreferenceKey {
    static var defaultValue: CGFloat? {
        nil
    }

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}
