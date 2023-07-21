//
//  BottomSheetPresentationDragIndicatorKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

/// A named value to configure the drag indicator visibility of the bottom sheet.
struct BottomSheetPresentationDragIndicatorKey: PreferenceKey {
    static var defaultValue: BottomSheetVisibility {
        .automatic
    }

    static func reduce(value: inout BottomSheetVisibility, nextValue: () -> BottomSheetVisibility) {
        value = nextValue()
    }
}
