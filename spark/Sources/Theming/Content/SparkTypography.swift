//
//  SparkTypography.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI
import UIKit

struct SparkTypography: Typography {

    // MARK: - Properties

    let display1: TypographyFontToken = TypographyFontTokenDefault(size: 40,
                                                                   isHighlighted: true,
                                                                   textStyle: .largeTitle)
    let display2: TypographyFontToken = TypographyFontTokenDefault(size: 32,
                                                                   isHighlighted: true,
                                                                   textStyle: .largeTitle)
    let display3: TypographyFontToken = TypographyFontTokenDefault(size: 24,
                                                                   isHighlighted: true,
                                                                   textStyle: .largeTitle)

    let headline1: TypographyFontToken = TypographyFontTokenDefault(size: 20,
                                                                    isHighlighted: true,
                                                                    textStyle: .headline)
    let headline2: TypographyFontToken = TypographyFontTokenDefault(size: 18,
                                                                    isHighlighted: true,
                                                                    textStyle: .headline)

    let subhead: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                  isHighlighted: true,
                                                                  textStyle: .subheadline)

    let body1: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                isHighlighted: false,
                                                                textStyle: .body)
    let body1Highlight: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                         isHighlighted: true,
                                                                         textStyle: .body)

    let body2: TypographyFontToken = TypographyFontTokenDefault(size: 14,
                                                                isHighlighted: false,
                                                                textStyle: .body)
    let body2Highlight: TypographyFontToken = TypographyFontTokenDefault(size: 14,
                                                                         isHighlighted: true,
                                                                         textStyle: .body)

    let caption: TypographyFontToken = TypographyFontTokenDefault(size: 12,
                                                                  isHighlighted: false,
                                                                  textStyle: .caption)
    let captionHighlight: TypographyFontToken = TypographyFontTokenDefault(size: 12,
                                                                           isHighlighted: true,
                                                                           textStyle: .caption)

    let small: TypographyFontToken = TypographyFontTokenDefault(size: 10,
                                                                isHighlighted: false,
                                                                textStyle: .footnote)
    let smallHighlight: TypographyFontToken = TypographyFontTokenDefault(size: 10,
                                                                         isHighlighted: true,
                                                                         textStyle: .footnote)

    let callout: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                  isHighlighted: true,
                                                                  textStyle: .callout)
}

// MARK: - TypographyFont Extension

private extension TypographyFontTokenDefault {

    // MARK: - Constants

    private enum Constants {
        static let boldFontName = "NunitoSans-Bold"
        static let regularFontName = "NunitoSans-Regular"
    }

    // MARK: - Initialization

    init(size: CGFloat,
         isHighlighted: Bool,
         textStyle: TextStyle) {
        // Properties
        let fontName = isHighlighted ? Constants.boldFontName : Constants.regularFontName
        self.init(named: fontName,
                  size: size,
                  textStyle: textStyle)
    }
}
