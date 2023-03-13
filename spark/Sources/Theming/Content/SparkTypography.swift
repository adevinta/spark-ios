//
//  SparkTypography.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import Foundation
import SparkCore
import SwiftUI
import UIKit

struct SparkTypography: Typography {
    
    // MARK: - Properties
    
    let display1: TypographyFont = TypographyFontDefault(size: 40,
                                                         isHighlight: true,
                                                         textStyle: .largeTitle)
    let display2: TypographyFont = TypographyFontDefault(size: 32,
                                                         isHighlight: true,
                                                         textStyle: .largeTitle)
    let display3: TypographyFont = TypographyFontDefault(size: 24,
                                                         isHighlight: true,
                                                         textStyle: .largeTitle)
    
    let headline1: TypographyFont = TypographyFontDefault(size: 20,
                                                          isHighlight: true,
                                                          textStyle: .headline)
    let headline2: TypographyFont = TypographyFontDefault(size: 18,
                                                          isHighlight: true,
                                                          textStyle: .headline)
    
    let subhead: TypographyFont = TypographyFontDefault(size: 16,
                                                        isHighlight: true,
                                                        textStyle: .subheadline)
    
    let body1: TypographyFont = TypographyFontDefault(size: 16,
                                                      isHighlight: false,
                                                      textStyle: .body)
    let body1Highlight: TypographyFont = TypographyFontDefault(size: 16,
                                                               isHighlight: true,
                                                               textStyle: .body)
    
    let body2: TypographyFont = TypographyFontDefault(size: 14,
                                                      isHighlight: false,
                                                      textStyle: .body)
    let body2Highlight: TypographyFont = TypographyFontDefault(size: 14,
                                                               isHighlight: true,
                                                               textStyle: .body)
    
    let caption: TypographyFont = TypographyFontDefault(size: 12,
                                                        isHighlight: false,
                                                        textStyle: .caption)
    let captionHighlight: TypographyFont = TypographyFontDefault(size: 12,
                                                                 isHighlight: true,
                                                                 textStyle: .caption)
    
    let small: TypographyFont = TypographyFontDefault(size: 10,
                                                      isHighlight: false,
                                                      textStyle: .footnote)
    let smallHighlight: TypographyFont = TypographyFontDefault(size: 10,
                                                               isHighlight: true,
                                                               textStyle: .footnote)
    
    let callout: TypographyFont = TypographyFontDefault(size: 16,
                                                        isHighlight: true,
                                                        textStyle: .callout)
}

// MARK: - TypographyFont Extension

private extension TypographyFontDefault {
    
    // MARK: - Constants
    
    private enum Constants {
        static let boldFontName = "NunitoSans-Bold"
        static let regularFontName = "NunitoSans-Regular"
    }
    
    // MARK: - Initialization
    
    init(size: CGFloat,
         isHighlight: Bool,
         textStyle: Font.TextStyle) {
        // Properties
        let fontName = isHighlight ? Constants.boldFontName : Constants.regularFontName
        let fontWeight: UIFont.Weight = isHighlight ? .bold : .regular

        self.init(named: fontName,
                  size: size,
                  weight: fontWeight,
                  textStyle: textStyle)
    }
}
