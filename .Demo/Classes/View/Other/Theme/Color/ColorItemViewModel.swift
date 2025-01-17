//
//  ColorItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ColorItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let color: Color
    let foregroundColor: Color

    // MARK: - Initialization

    init(name: String,
         colorToken: any ColorToken) {
        self.name = name
        self.foregroundColor = Self.makeForegroundColor(colorToken: colorToken)
        self.color = colorToken.color
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    // MARK: - Color

    private static func makeForegroundColor(colorToken: any ColorToken) -> Color {
        let uiColor = colorToken.uiColor
        return uiColor.isLight ? .black : .white
    }
}

// MARK: - UIColor Extension

extension UIColor {
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
