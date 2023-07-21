//
//  BottomSheetPresentationDetentsKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

/// A named value to configure the available detents of the bottom sheet.
struct BottomSheetPresentationDetentsKey: PreferenceKey {
    static var defaultValue: [BottomSheetPresentationDetent] {
        [.natural]
    }

    static func reduce(value: inout [BottomSheetPresentationDetent], nextValue: () -> [BottomSheetPresentationDetent]) {
        value = nextValue()
    }
}
