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
                .init(name: "alert - fill", iconographyImage: iconography.alert.fill),
                .init(name: "alert - outlined", iconographyImage: iconography.alert.outlined)
            ],

            [
                .init(name: "question - fill", iconographyImage: iconography.question.fill),
                .init(name: "question - outlined", iconographyImage: iconography.question.outlined)
            ],

            [
                .init(name: "info - fill", iconographyImage: iconography.info.fill),
                .init(name: "info - outlined", iconographyImage: iconography.info.outlined)
            ],

            [
                .init(name: "warning - fill", iconographyImage: iconography.warning.fill),
                .init(name: "warning - outlined", iconographyImage: iconography.warning.outlined)
            ],

            [
                .init(name: "block", iconographyImage: iconography.block)
            ]
        ]
    }
}
