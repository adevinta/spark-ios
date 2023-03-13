//
//  IconographySectionMapViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionMapViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyMap) {
        self.name = "map"
        self.itemViewModels = [
            [
                .init(name: "threeSixty", iconographyImage: iconography.threeSixty),
                .init(name: "bike", iconographyImage: iconography.bike),
                .init(name: "allDirections", iconographyImage: iconography.allDirections),
                .init(name: "expand", iconographyImage: iconography.expand)
            ],
            Helper.makeFilledAndOutlineViewModels(name: "target", iconography: iconography.target),
            Helper.makeFilledAndOutlineViewModels(name: "pin", iconography: iconography.pin),
            Helper.makeFilledAndOutlineViewModels(name: "cursor", iconography: iconography.cursor),
            Helper.makeFilledAndOutlineViewModels(name: "train", iconography: iconography.train),
            Helper.makeFilledAndOutlineViewModels(name: "hotel", iconography: iconography.hotel),
            Helper.makeFilledAndOutlineViewModels(name: "walker", iconography: iconography.walker),
            Helper.makeFilledAndOutlineViewModels(name: "car", iconography: iconography.car)
        ]
    }
}
