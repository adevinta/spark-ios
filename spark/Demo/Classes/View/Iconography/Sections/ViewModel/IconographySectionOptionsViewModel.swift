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
            Helper.makeFillAndOutlineViewModels(name: "clock", iconography: iconography.clock),
            Helper.makeFillAndOutlineViewModels(name: "flash", iconography: iconography.flash),
            Helper.makeFillAndOutlineViewModels(name: "bookmark", iconography: iconography.bookmark),
            Helper.makeFillAndOutlineViewModels(name: "star", iconography: iconography.star),
            Helper.makeUpAndDownViewModels(name: "clockArrow", iconography: iconography.clockArrow),
            [
                .init(name: "moveUp", iconographyImage: iconography.moveUp)
            ]
        ]
    }
}
