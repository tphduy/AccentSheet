//
//  BottomSheetPresentationPassthroughBackgroundDisabledKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 20/07/2023.
//

import SwiftUI

/// A named value to configure the passthrough background of the bottom sheet.
struct BottomSheetPresentationPassthroughBackgroundDisabledKey: PreferenceKey {
    static var defaultValue: Bool {
        false
    }

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
