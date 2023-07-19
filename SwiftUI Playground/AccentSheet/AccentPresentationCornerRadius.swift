//
//  AccentPresentationCornerRadius.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

struct AccentPresentationCornerRadiusKey: PreferenceKey {
    static var defaultValue: CGFloat? {
        nil
    }

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}
