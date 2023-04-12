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
    var display1: TypographyFontToken { get }
    var display2: TypographyFontToken { get }
    var display3: TypographyFontToken { get }

    var headline1: TypographyFontToken { get }
    var headline2: TypographyFontToken { get }

    var subhead: TypographyFontToken { get }

    var body1: TypographyFontToken { get }
    var body1Highlight: TypographyFontToken { get }

    var body2: TypographyFontToken { get }
    var body2Highlight: TypographyFontToken { get }

    var caption: TypographyFontToken { get }
    var captionHighlight: TypographyFontToken { get }

    var small: TypographyFontToken { get }
    var smallHighlight: TypographyFontToken { get }

    var callout: TypographyFontToken { get }
}

// MARK: - Font

// sourcery: AutoMockable
public protocol TypographyFontToken {
    var uiFont: UIFont { get }
    var font: Font { get }
}
