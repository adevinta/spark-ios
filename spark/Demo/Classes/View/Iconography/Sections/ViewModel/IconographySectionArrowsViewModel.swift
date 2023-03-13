//
//  IconographySectionArrowsViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionArrowsViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyArrows) {
        self.name = "arrows"
        self.itemViewModels = [
            Helper.makeLeftAndRightViewModels(name: "arrow", iconography: iconography.arrow),
            Helper.makeLeftAndRightViewModels(name: "arrowDouble", iconography: iconography.arrowDouble),
            Helper.makeLeftAndRightViewModels(name: "arrowVertical", iconography: iconography.arrowVertical),
            Helper.makeUpAndDownViewModels(name: "arrowHorizontal", iconography: iconography.arrowHorizontal),
            Helper.makeFillAndOutlineViewModels(name: "delete", iconography: iconography.delete),
            Helper.makeUpAndDownViewModels(name: "graphArrow", iconography: iconography.graphArrow),
            [
                .init(name: "close", iconographyImage: iconography.close),
                .init(name: "plus", iconographyImage: iconography.plus)
            ]
        ]
    }
}
