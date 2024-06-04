//
//  TextLinkTypographies.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct TextLinkTypographies: Equatable {

    // MARK: - Properties

    let normal: any TypographyFontToken
    let highlight: any TypographyFontToken

    // MARK: - Equatable

    static func == (lhs: TextLinkTypographies, rhs: TextLinkTypographies) -> Bool {
        return lhs.normal.font == rhs.normal.font &&
        lhs.normal.uiFont == rhs.normal.uiFont &&
        lhs.highlight.font == rhs.highlight.font &&
        lhs.highlight.uiFont == rhs.highlight.uiFont
    }
}
