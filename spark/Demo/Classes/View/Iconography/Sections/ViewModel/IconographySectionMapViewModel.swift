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
            Helper.makeFillAndOutlineViewModels(name: "target", iconography: iconography.target),
            Helper.makeFillAndOutlineViewModels(name: "pin", iconography: iconography.pin),
            Helper.makeFillAndOutlineViewModels(name: "cursor", iconography: iconography.cursor),
            Helper.makeFillAndOutlineViewModels(name: "train", iconography: iconography.train),
            Helper.makeFillAndOutlineViewModels(name: "hotel", iconography: iconography.hotel),
            Helper.makeFillAndOutlineViewModels(name: "walker", iconography: iconography.walker),
            Helper.makeFillAndOutlineViewModels(name: "car", iconography: iconography.car)
        ]
    }
}
