//
//  Typography.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

// sourcery: AutoMockable
public protocol Typography {
    var display1: any TypographyFontToken { get }
    var display2: any TypographyFontToken { get }
    var display3: any TypographyFontToken { get }

    var headline1: any TypographyFontToken { get }
    var headline2: any TypographyFontToken { get }

    var subhead: any TypographyFontToken { get }

    var body1: any TypographyFontToken { get }
    var body1Highlight: any TypographyFontToken { get }

    var body2: any TypographyFontToken { get }
    var body2Highlight: any TypographyFontToken { get }

    var caption: any TypographyFontToken { get }
    var captionHighlight: any TypographyFontToken { get }

    var small: any TypographyFontToken { get }
    var smallHighlight: any TypographyFontToken { get }

    var callout: any TypographyFontToken { get }
}

// MARK: - Font

// sourcery: AutoMockable
public protocol TypographyFontToken {
    var uiFont: UIFont { get }
    var font: Font { get }
}
