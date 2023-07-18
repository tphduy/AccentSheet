//
//  AccentSheetConfiguration.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

struct AccentSheetConfiguration {
    var edgesIgnoringSafeArea: Edge.Set = []
    
    /// The guide for aligning the header and the content in a vertical stack.
    ///
    /// The default value is `.center`.
    var alignment: HorizontalAlignment = .center

    /// The distance between the header and the content in a vertical stack..
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
}
