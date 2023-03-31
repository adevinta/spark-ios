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

    public let display1: TypographyFontToken
    public let display2: TypographyFontToken
    public let display3: TypographyFontToken

    public let headline1: TypographyFontToken
    public let headline2: TypographyFontToken

    public let subhead: TypographyFontToken

    public let body1: TypographyFontToken
    public let body1Highlight: TypographyFontToken

    public let body2: TypographyFontToken
    public let body2Highlight: TypographyFontToken

    public let caption: TypographyFontToken
    public let captionHighlight: TypographyFontToken

    public let small: TypographyFontToken
    public let smallHighlight: TypographyFontToken

    public let callout: TypographyFontToken

    // MARK: - Initialization

    public init(display1: TypographyFontToken,
                display2: TypographyFontToken,
                display3: TypographyFontToken,
                headline1: TypographyFontToken,
                headline2: TypographyFontToken,
                subhead: TypographyFontToken,
                body1: TypographyFontToken,
                body1Highlight: TypographyFontToken,
                body2: TypographyFontToken,
                body2Highlight: TypographyFontToken,
                caption: TypographyFontToken,
                captionHighlight: TypographyFontToken,
                small: TypographyFontToken,
                smallHighlight: TypographyFontToken,
                callout: TypographyFontToken) {
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
    private let fontWeight: UIFont.Weight
    private let fontTextStyle: Font.TextStyle

    public var uiFont: UIFont {
        return UIFont(name: self.fontName, size: self.fontSize) ?? .systemFont(ofSize: self.fontSize, weight: self.fontWeight)
    }
    
    public var font: Font {
        return Font.custom(self.fontName,
                           size: self.fontSize,
                           relativeTo: self.fontTextStyle)
    }

    // MARK: - Initialization

    public init(named fontName: String,
                size: CGFloat,
                weight: UIFont.Weight,
                textStyle: Font.TextStyle) {
        self.fontName = fontName
        self.fontSize = size
        self.fontWeight = weight
        self.fontTextStyle = textStyle
    }
}
