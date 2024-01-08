//
//  TypographyDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

public struct TypographyDefault: Typography {

    // MARK: - Properties

    public let display1: any TypographyFontToken
    public let display2: any TypographyFontToken
    public let display3: any TypographyFontToken

    public let headline1: any TypographyFontToken
    public let headline2: any TypographyFontToken

    public let subhead: any TypographyFontToken

    public let body1: any TypographyFontToken
    public let body1Highlight: any TypographyFontToken

    public let body2: any TypographyFontToken
    public let body2Highlight: any TypographyFontToken

    public let caption: any TypographyFontToken
    public let captionHighlight: any TypographyFontToken

    public let small: any TypographyFontToken
    public let smallHighlight: any TypographyFontToken

    public let callout: any TypographyFontToken

    // MARK: - Initialization

    public init(display1: some TypographyFontToken,
                display2: some TypographyFontToken,
                display3: some TypographyFontToken,
                headline1: some TypographyFontToken,
                headline2: some TypographyFontToken,
                subhead: some TypographyFontToken,
                body1: some TypographyFontToken,
                body1Highlight: some TypographyFontToken,
                body2: some TypographyFontToken,
                body2Highlight: some TypographyFontToken,
                caption: some TypographyFontToken,
                captionHighlight: some TypographyFontToken,
                small: some TypographyFontToken,
                smallHighlight: some TypographyFontToken,
                callout: some TypographyFontToken) {
        self.display1 = display1
        self.display2 = display2
        self.display3 = display3
        self.headline1 = headline1
        self.headline2 = headline2
        self.subhead = subhead
        self.body1 = body1
        self.body1Highlight = body1Highlight
        self.body2 = body2
        self.body2Highlight = body2Highlight
        self.caption = caption
        self.captionHighlight = captionHighlight
        self.small = small
        self.smallHighlight = smallHighlight
        self.callout = callout
    }
}

// MARK: - Font

public struct TypographyFontTokenDefault: TypographyFontToken {

    // MARK: - Properties

    private let fontName: String
    private let fontSize: CGFloat
    private let fontTextStyle: TextStyle

    public var uiFont: UIFont {
        guard let font = UIFont(name: self.fontName, size: self.fontSize) else {
            fatalError("Missing font named \(self.fontName)")
        }
        let textStyle = UIFont.TextStyle(from: self.fontTextStyle)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
    
    public var font: Font {
        let textStyle = Font.TextStyle(from: self.fontTextStyle)
        return Font.custom(self.fontName,
                           size: self.fontSize,
                           relativeTo: textStyle)
    }

    // MARK: - Initialization

    public init(named fontName: String,
                size: CGFloat,
                textStyle: TextStyle) {
        self.fontName = fontName
        self.fontSize = size
        self.fontTextStyle = textStyle
    }
}
