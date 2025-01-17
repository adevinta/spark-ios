//
//  ColorSectionStatesViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//


struct ColorSectionStatesViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsStates) {
        self.name = "States"
        self.itemViewModels = [
            [
                .init(name: "mainPressed", colorToken: color.mainPressed),
                .init(name: "mainVariantPressed", colorToken: color.mainVariantPressed),
                .init(name: "mainContainerPressed", colorToken: color.mainContainerPressed),
                .init(name: "supportPressed", colorToken: color.supportPressed),
                .init(name: "supportVariantPressed", colorToken: color.supportVariantPressed),
                .init(name: "supportContainerPressed", colorToken: color.supportContainerPressed),
                .init(name: "accentPressed", colorToken: color.accentPressed),
                .init(name: "accentVariantPressed", colorToken: color.accentVariantPressed),
                .init(name: "accentContainerPressed", colorToken: color.accentContainerPressed),
                .init(name: "basicPressed", colorToken: color.basicPressed),
                .init(name: "basicContainerPressed", colorToken: color.basicContainerPressed),
                .init(name: "surfacePressed", colorToken: color.surfacePressed),
                .init(name: "surfaceInversePressed", colorToken: color.surfaceInversePressed),
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
