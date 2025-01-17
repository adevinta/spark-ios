//
//  ColorSectionAccentViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


struct ColorSectionAccentViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsAccent) {
        self.name = "Accent"
        self.itemViewModels = [
            [
                .init(name: "accent", colorToken: color.accent),
                .init(name: "onAccent", colorToken: color.onAccent),
                .init(name: "accentVariant", colorToken: color.accentVariant),
                .init(name: "onAccentVariant", colorToken: color.onAccentVariant),
                .init(name: "accentContainer", colorToken: color.accentContainer),
                .init(name: "onAccentContainer", colorToken: color.onAccentContainer)
            ]
        ]
    }
}
