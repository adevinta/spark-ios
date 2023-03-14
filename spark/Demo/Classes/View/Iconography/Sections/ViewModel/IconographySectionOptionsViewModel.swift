//
//  IconographySectionOptionsViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionOptionsViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyOptions) {
        self.name = "options"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "clock", iconography: iconography.clock),
            Helper.makeFilledAndOutlineViewModels(name: "flash", iconography: iconography.flash),
            Helper.makeFilledAndOutlineViewModels(name: "bookmark", iconography: iconography.bookmark),
            Helper.makeFilledAndOutlineViewModels(name: "star", iconography: iconography.star),
            Helper.makeUpAndDownViewModels(name: "clockArrow", iconography: iconography.clockArrow),
            [
                .init(name: "moveUp", iconographyImage: iconography.moveUp)
            ]
        ]
    }
}
