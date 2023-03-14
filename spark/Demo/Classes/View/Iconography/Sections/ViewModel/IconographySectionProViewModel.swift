//
//  IconographySectionProViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionProViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyPro) {
        self.name = "pro"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "cursor", iconography: iconography.cursor),
            Helper.makeFilledAndOutlineViewModels(name: "download", iconography: iconography.download),
            Helper.makeFilledAndOutlineViewModels(name: "graph", iconography: iconography.graph),
            Helper.makeFilledAndOutlineViewModels(name: "rocket", iconography: iconography.rocket)
        ]
    }
}
