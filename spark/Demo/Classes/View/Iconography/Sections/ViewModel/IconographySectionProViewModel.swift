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
            Helper.makeFillAndOutlineViewModels(name: "cursor", iconography: iconography.cursor),
            Helper.makeFillAndOutlineViewModels(name: "download", iconography: iconography.download),
            Helper.makeFillAndOutlineViewModels(name: "graph", iconography: iconography.graph),
            Helper.makeFillAndOutlineViewModels(name: "rocket", iconography: iconography.rocket)
        ]
    }
}
