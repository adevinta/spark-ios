//
//  RadioButtonAttributes.swift
//  SparkCore
//
//  Created by michael.zimmermann on 18.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

struct RadioButtonAttributes: Equatable {
    let colors: RadioButtonColors
    let opacity: CGFloat
    let spacing: CGFloat
    let font: any TypographyFontToken

    static func == (lhs: RadioButtonAttributes, rhs: RadioButtonAttributes) -> Bool {
        return lhs.colors == rhs.colors &&
        lhs.opacity == rhs.opacity &&
        lhs.spacing == rhs.spacing &&
        lhs.font.uiFont == rhs.font.uiFont
    }
}
