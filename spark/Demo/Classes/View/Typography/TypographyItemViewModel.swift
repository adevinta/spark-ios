//
//  TypographyItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct TypographyItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let description: String
    let font: Font

    // MARK: - Initialization

    init(name: String,
         typographyFont: TypographyFont) {
        self.name = name
        self.description = typographyFont.uiFont.fontName + "\(Int(typographyFont.uiFont.pointSize))"
        self.font = typographyFont.swiftUIFont
    }
}
