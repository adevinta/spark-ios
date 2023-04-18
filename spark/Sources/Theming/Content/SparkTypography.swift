//
//  SparkTypography.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkCore
import SwiftUI
import UIKit

struct SparkTypography: Typography {
    
    // MARK: - Properties
    
    let display1: TypographyFontToken = TypographyFontTokenDefault(size: 40,
                                                                   isHighlight: true,
                                                                   textStyle: .largeTitle)
    let display2: TypographyFontToken = TypographyFontTokenDefault(size: 32,
                                                                   isHighlight: true,
                                                                   textStyle: .largeTitle)
    let display3: TypographyFontToken = TypographyFontTokenDefault(size: 24,
                                                                   isHighlight: true,
                                                                   textStyle: .largeTitle)
    
    let headline1: TypographyFontToken = TypographyFontTokenDefault(size: 20,
                                                                    isHighlight: true,
                                                                    textStyle: .headline)
    let headline2: TypographyFontToken = TypographyFontTokenDefault(size: 18,
                                                                    isHighlight: true,
                                                                    textStyle: .headline)
    
    let subhead: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                  isHighlight: true,
                                                                  textStyle: .subheadline)
    
    let body1: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                isHighlight: false,
                                                                textStyle: .body)
    let body1Highlight: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                         isHighlight: true,
                                                                         textStyle: .body)
    
    let body2: TypographyFontToken = TypographyFontTokenDefault(size: 14,
                                                                isHighlight: false,
                                                                textStyle: .body)
    let body2Highlight: TypographyFontToken = TypographyFontTokenDefault(size: 14,
                                                                         isHighlight: true,
                                                                         textStyle: .body)
    
    let caption: TypographyFontToken = TypographyFontTokenDefault(size: 12,
                                                                  isHighlight: false,
                                                                  textStyle: .caption)
    let captionHighlight: TypographyFontToken = TypographyFontTokenDefault(size: 12,
                                                                           isHighlight: true,
                                                                           textStyle: .caption)
    
    let small: TypographyFontToken = TypographyFontTokenDefault(size: 10,
                                                                isHighlight: false,
                                                                textStyle: .footnote)
    let smallHighlight: TypographyFontToken = TypographyFontTokenDefault(size: 10,
                                                                         isHighlight: true,
                                                                         textStyle: .footnote)
    
    let callout: TypographyFontToken = TypographyFontTokenDefault(size: 16,
                                                                  isHighlight: true,
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
         isHighlight: Bool,
         textStyle: TextStyle) {
        // Properties
        let fontName = isHighlight ? Constants.boldFontName : Constants.regularFontName
        let fontWeight: UIFont.Weight = isHighlight ? .bold : .regular

        self.init(named: fontName,
                  size: size,
                  weight: fontWeight,
                  textStyle: textStyle)
    }
}
