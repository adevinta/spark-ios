//
//  ColorSectionSupportViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//


struct ColorSectionSupportViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsSupport) {
        self.name = "Support"
        self.itemViewModels = [
            [
                .init(name: "support", colorToken: color.support),
                .init(name: "onSupport", colorToken: color.onSupport),
                .init(name: "supportVariant", colorToken: color.supportVariant),
                .init(name: "onSupportVariant", colorToken: color.onSupportVariant),
                .init(name: "supportContainer", colorToken: color.supportContainer),
                .init(name: "onSupportContainer", colorToken: color.onSupportContainer)
            ]
        ]
    }
}
