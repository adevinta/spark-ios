//
//  TypographyItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct TypographyItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let description: String
    let font: Font

    // MARK: - Initialization

    init(name: String,
         token: TypographyFontToken) {
        self.name = name
        self.description = token.uiFont.fontName + "\(Int(token.uiFont.pointSize))"
        self.font = token.font
    }
}
