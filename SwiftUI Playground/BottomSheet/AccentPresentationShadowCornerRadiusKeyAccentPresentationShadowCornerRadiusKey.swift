//
//  BottomSheetPresentationShadowCornerRadiusKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

/// A named value to configure the shadow corner radius of the bottom sheet.
struct BottomSheetPresentationShadowCornerRadiusKey: PreferenceKey {
    static var defaultValue: CGFloat {
        0
    }

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
