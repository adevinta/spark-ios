//
//  ColorSectionStatesViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct ColorSectionStatesViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization
    
    init(color: ColorsStates) {
        self.name = "states"
        self.itemViewModels = [
            [
                .init(name: "primaryPressed", colorToken: color.primaryPressed),
                .init(name: "primaryVariantPressed", colorToken: color.primaryVariantPressed),
                .init(name: "primaryContainerPressed", colorToken: color.primaryContainerPressed),
                .init(name: "secondaryPressed", colorToken: color.secondaryPressed),
                .init(name: "secondaryVariantPressed", colorToken: color.secondaryVariantPressed),
                .init(name: "secondaryContainerPressed", colorToken: color.secondaryContainerPressed),
                .init(name: "surfacePressed", colorToken: color.surfacePressed),
                .init(name: "surfaceInversePressed", colorToken: color.surfaceInversePressed),
                .init(name: "outlinePressed", colorToken: color.outlinePressed),
                .init(name: "successPressed", colorToken: color.successPressed),
                .init(name: "successContainerPressed", colorToken: color.successContainerPressed),
                .init(name: "alertPressed", colorToken: color.alertPressed),
                .init(name: "alertContainerPressed", colorToken: color.alertContainerPressed),
                .init(name: "errorPressed", colorToken: color.errorPressed),
                .init(name: "errorContainerPressed", colorToken: color.errorContainerPressed),
                .init(name: "infoPressed", colorToken: color.infoPressed),
                .init(name: "infoContainerPressed", colorToken: color.infoContainerPressed),
                .init(name: "neutralPressed", colorToken: color.neutralPressed),
                .init(name: "neutralContainerPressed", colorToken: color.neutralContainerPressed)
            ]
        ]
    }
}
