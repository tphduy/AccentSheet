//
//  AccentVisibility.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 19/07/2023.
//

import SwiftUI

/// The visibility of a UI element, chosen automatically based on the platform, current context, and other factors.
enum AccentVisibility {
    /// The element may be visible or hidden depending on the policies of the component accepting the visibility configuration.
    case automatic
    /// The element may be visible.
    case visible
    /// The element may be hidden.
    case hidden
}
