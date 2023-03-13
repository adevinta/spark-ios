//
//  IconographySectionAlertViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionAlertViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyAlert) {
        self.name = "alert"
        self.itemViewModels = [
            [
                .init(name: "alert - filled", iconographyImage: iconography.alert.filled),
                .init(name: "alert - outlined", iconographyImage: iconography.alert.outlined)
            ],

            [
                .init(name: "question - filled", iconographyImage: iconography.question.filled),
                .init(name: "question - outlined", iconographyImage: iconography.question.outlined)
            ],

            [
                .init(name: "info - filled", iconographyImage: iconography.info.filled),
                .init(name: "info - outlined", iconographyImage: iconography.info.outlined)
            ],

            [
                .init(name: "warning - filled", iconographyImage: iconography.warning.filled),
                .init(name: "warning - outlined", iconographyImage: iconography.warning.outlined)
            ],

            [
                .init(name: "block", iconographyImage: iconography.block)
            ]
        ]
    }
}
