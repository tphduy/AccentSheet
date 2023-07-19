//
//  AccentPresentationConfiguration.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

/// A group of properties to configure an accent sheet.
struct AccentPresentationConfiguration: Equatable {
    /// The distance between the drag indicator and the content in a vertical stack..
    ///
    /// The default value is `0`.
    var spacing: CGFloat = 0

    /// The radius of the rounded corners of the background.
    ///
    /// The default value is `8`.
    var cornerRadius: CGFloat = 8

    /// A flag that indicates whether the shadow of bottom sheet is enabled.
    ///
    /// The defualt value is `true`.
    var isShadowEnabled: Bool = true

    /// A flag that indicates whether a view between the presenting view and the sheet is enabled that passes through the gesture or dismisses when tapped.
    ///
    /// The defualt value is `true`.
    var isPassthroughtBackgroundEnabled: Bool = true
}

struct AccentPresentationConfigurationKey: PreferenceKey {
    static var defaultValue: AccentPresentationConfiguration {
        AccentPresentationConfiguration()
    }

    static func reduce(value: inout AccentPresentationConfiguration, nextValue: () -> AccentPresentationConfiguration) {
        value = nextValue()
    }
}
