//
//  IconographySectionToggleViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionToggleViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyToggle) {
        self.name = "toggle"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "valid", iconography: iconography.valid),
            Helper.makeFilledAndOutlineViewModels(name: "add", iconography: iconography.add),
            Helper.makeFilledAndOutlineViewModels(name: "remove", iconography: iconography.remove),

            [
                .init(name: "check", iconographyImage: iconography.check),
                .init(name: "doubleCheck", iconographyImage: iconography.doubleCheck)
            ]
        ]
    }
}
