//
//  BottomSheetPresentationCornerRadiusKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

/// A named value to configure the corner radius of the bottom sheet.
struct BottomSheetPresentationCornerRadiusKey: PreferenceKey {
    static var defaultValue: CGFloat? {
        nil
    }

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}
