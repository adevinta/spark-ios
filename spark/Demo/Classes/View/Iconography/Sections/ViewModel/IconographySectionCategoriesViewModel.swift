//
//  IconographySectionCategoriesViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionCategoriesViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyCategories) {
        self.name = "categories"
        self.itemViewModels = [
            [
                .init(name: "apartment", iconographyImage: iconography.apartment),
                .init(name: "vehicles", iconographyImage: iconography.vehicles),
                .init(name: "couch", iconographyImage: iconography.couch),
                .init(name: "equipment", iconographyImage: iconography.equipment),
                .init(name: "hobby", iconographyImage: iconography.hobby),
                .init(name: "ground", iconographyImage: iconography.ground),
                .init(name: "holidays", iconographyImage: iconography.holidays),
                .init(name: "land", iconographyImage: iconography.land),
                .init(name: "clothes", iconographyImage: iconography.clothes),
                .init(name: "dress", iconographyImage: iconography.dress),
                .init(name: "baby", iconographyImage: iconography.baby),
                .init(name: "multimedia", iconographyImage: iconography.multimedia),
                .init(name: "parking", iconographyImage: iconography.parking),
                .init(name: "house", iconographyImage: iconography.house),
                .init(name: "service", iconographyImage: iconography.service),
                .init(name: "job", iconographyImage: iconography.job),
                .init(name: "pets", iconographyImage: iconography.pets),
                .init(name: "computer", iconographyImage: iconography.computer)
            ]
        ]
    }
}
