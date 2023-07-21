//
//  BottomSheetInteractiveDismissDisabledKey.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

/// A named value to configure the interactive dismissal of the bottom sheet.
struct BottomSheetInteractiveDismissDisabledKey: PreferenceKey {
    static var defaultValue: Bool {
        false
    }

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
