//
//  AccentPresentationDentent.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 27/06/2023.
//

import SwiftUI

/// A type that represents a height where a sheet naturally rests.
public enum AccentPresentationDetent: Hashable {
    /// The system detent for a sheet that grows to its natural size based on its content.
    case natural

    /// The system detent for a sheet that's approximately half the height of the screen, and is inactive in compact height.
    case medium

    /// The system detent for a sheet at full height.
    case large

    /// A custom detent with the specified fractional height.
    case fraction(_ fraction: CGFloat)

    /// A custom detent with the specified height.
    case height(_ height: CGFloat)
}

struct AccentPresentationDetentsKey: PreferenceKey {
    static var defaultValue: [AccentPresentationDetent] {
        [.natural]
    }

    static func reduce(value: inout [AccentPresentationDetent], nextValue: () -> [AccentPresentationDetent]) {
        value = nextValue()
    }
}
