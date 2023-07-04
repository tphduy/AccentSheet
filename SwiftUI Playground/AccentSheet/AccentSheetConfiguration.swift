//
//  AccentSheetConfiguration.swift
//  SwiftUI Playground
//
//  Created by Duy Tran on 29/06/2023.
//

import SwiftUI

public struct AccentSheetConfiguration {
    /// The guide for aligning the header and the content in a vertical stack.
    ///
    /// The default value is `.center`.
    public var alignment: HorizontalAlignment = .center

    /// The distance between the header and the content in a vertical stack..
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

    /// The supported detents for the sheet. If you provide more that one detent, the user can drag the sheet to resize it.
    ///
    /// The default value is `.natural` and will take place if the list is empty.
    public var presentationDetents: [AccentPresentationDentent] = [.natural]
}
