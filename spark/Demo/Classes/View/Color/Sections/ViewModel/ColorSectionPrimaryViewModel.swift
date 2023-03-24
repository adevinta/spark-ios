//
//  ColorSectionPrimaryViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct ColorSectionPrimaryViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization
    
    init(color: ColorsPrimary) {
        self.name = "primary"
        self.itemViewModels = [
            [
                .init(name: "primary", colorToken: color.primary),
                .init(name: "onPrimary", colorToken: color.onPrimary),
                .init(name: "primaryVariant", colorToken: color.primaryVariant),
                .init(name: "onPrimaryVariant", colorToken: color.onPrimaryVariant),
                .init(name: "primaryContainer", colorToken: color.primaryContainer),
                .init(name: "onPrimaryContainer", colorToken: color.onPrimaryContainer)
            ]
        ]
    }
}
