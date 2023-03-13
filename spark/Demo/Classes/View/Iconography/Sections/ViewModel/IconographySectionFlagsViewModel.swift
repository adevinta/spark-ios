//
//  IconographySectionFlagsViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionFlagsViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper
    
    // MARK: - Properties
    
    let name: String
    let itemViewModels: [[IconographyItemViewModel]]
    
    // MARK: - Initialization
    
    init(iconography: IconographyFlags) {
        self.name = "flags"
        self.itemViewModels = [
            [
                .init(name: "at", iconographyImage: iconography.at),
                .init(name: "be", iconographyImage: iconography.be),
                .init(name: "br", iconographyImage: iconography.br),
                .init(name: "by", iconographyImage: iconography.by),
                .init(name: "ch", iconographyImage: iconography.ch),
                .init(name: "cl", iconographyImage: iconography.cl),
                .init(name: "co", iconographyImage: iconography.co),
                .init(name: "do", iconographyImage: iconography.do),
                .init(name: "es", iconographyImage: iconography.es),
                .init(name: "fi", iconographyImage: iconography.fi),
                .init(name: "fr", iconographyImage: iconography.fr),
                .init(name: "hu", iconographyImage: iconography.hu),
                .init(name: "id", iconographyImage: iconography.id),
                .init(name: "ie", iconographyImage: iconography.ie),
                .init(name: "it", iconographyImage: iconography.it)
            ]
        ]
    }
}
