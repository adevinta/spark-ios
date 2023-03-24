//
//  ColorSectionSecondaryViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct ColorSectionSecondaryViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization
    
    init(color: ColorsSecondary) {
        self.name = "secondary"
        self.itemViewModels = [
            [
                .init(name: "secondary", colorToken: color.secondary),
                .init(name: "onSecondary", colorToken: color.onSecondary),
                .init(name: "secondaryVariant", colorToken: color.secondaryVariant),
                .init(name: "onSecondaryVariant", colorToken: color.onSecondaryVariant),
                .init(name: "secondaryContainer", colorToken: color.secondaryContainer),
                .init(name: "onSecondaryContainer", colorToken: color.onSecondaryContainer)
            ]
        ]
    }
}
