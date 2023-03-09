//
//  Typography.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public protocol Typography {
    var display1: TypographyFont { get }
    var display2: TypographyFont { get }
    var display3: TypographyFont { get }

    var headline1: TypographyFont { get }
    var headline2: TypographyFont { get }

    var subhead: TypographyFont { get }

    var body1: TypographyFont { get }
    var body1Highlight: TypographyFont { get }

    var body2: TypographyFont { get }
    var body2Highlight: TypographyFont { get }

    var caption: TypographyFont { get }
    var captionHighlight: TypographyFont { get }

    var small: TypographyFont { get }
    var smallHighlight: TypographyFont { get }

    var callout: TypographyFont { get }
}

// MARK: - Font

public protocol TypographyFont {
    var font: UIFont { get }
    var swiftUIFont: Font { get }
}
