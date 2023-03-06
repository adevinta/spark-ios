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
    
    let display1: TypographyFont = .init(size: 40,
                                         isHighlight: true,
                                         textStyle: .largeTitle)
    let display2: TypographyFont = .init(size: 32,
                                         isHighlight: true,
                                         textStyle: .largeTitle)
    let display3: TypographyFont = .init(size: 24,
                                         isHighlight: true,
                                         textStyle: .largeTitle)
    
    let headline1: TypographyFont = .init(size: 20,
                                          isHighlight: true,
                                          textStyle: .headline)
    let headline2: TypographyFont = .init(size: 18,
                                          isHighlight: true,
                                          textStyle: .headline)
    
    let subhead: TypographyFont = .init(size: 16,
                                        isHighlight: true,
                                        textStyle: .subheadline)
    
    let body1: TypographyFont = .init(size: 16,
                                      isHighlight: false,
                                      textStyle: .body)
    let body1Highlight: TypographyFont = .init(size: 16,
                                               isHighlight: true,
                                               textStyle: .body)
    
    let body2: TypographyFont = .init(size: 14,
                                      isHighlight: false,
                                      textStyle: .body)
    let body2Highlight: TypographyFont = .init(size: 14,
                                               isHighlight: true,
                                               textStyle: .body)
    
    let caption: TypographyFont = .init(size: 12,
                                        isHighlight: false,
                                        textStyle: .caption)
    let captionHighlight: TypographyFont = .init(size: 12,
                                                 isHighlight: true,
                                                 textStyle: .caption)
    
    let small: TypographyFont = .init(size: 10,
                                      isHighlight: false,
                                      textStyle: .footnote)
    let smallHighlight: TypographyFont = .init(size: 10,
                                               isHighlight: true,
                                               textStyle: .footnote)
    
    let callout: TypographyFont = .init(size: 16,
                                        isHighlight: true,
                                        textStyle: .callout)
}

// MARK: - TypographyFont Extension

private extension TypographyFont {
    
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
        
        // Fonts
        let font = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size, weight: fontWeight)
        let swiftUIFont = Font.custom(fontName, size: size, relativeTo: textStyle)
        
        self.init(font: font,
                  swiftUIFont: swiftUIFont)
    }
}
