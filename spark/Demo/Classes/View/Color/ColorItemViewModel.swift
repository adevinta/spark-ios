//
//  ColorItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct ColorItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let states: [ColorItemStateViewModel]

    // MARK: - Initialization

    init(name: String,
         colorToken: ColorToken) {
        self.name = name
        self.states = [
            .init(name: "enabled", colorValue: colorToken.enabled),
            .init(name: "pressed", colorValue: colorToken.pressed),
            .init(name: "disabled", colorValue: colorToken.disabled),
            .init(name: "on", colorValue: colorToken.on)
        ]
    }
}

struct ColorItemStateViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let color: Color

    // MARK: - Initialization

    init(name: String, colorValue: ColorTokenValue) {
        self.name = name
        self.color = colorValue.swiftUIColor
    }
}
