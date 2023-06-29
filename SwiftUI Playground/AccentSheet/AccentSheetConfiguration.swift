//
//  AccentSheetConfiguration.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import Foundation

public struct AccentSheetConfiguration {
    /// The distance between the header and the content.
    ///
    /// The default value is `0`.
    public var spacing: CGFloat = 0

    /// The radius of the rounded corners of the background.
    ///
    /// The default value is `8`.
    public var cornerRadius: CGFloat = 8

    /// A flag that indicates whether the shadow of bottom sheet is enabled.
    ///
    /// The defualt value is `true`.
    public var isShadowEnabled: Bool = true

    public var presentationDetents: [AccentPresentationDentent] = [.natural]
}
