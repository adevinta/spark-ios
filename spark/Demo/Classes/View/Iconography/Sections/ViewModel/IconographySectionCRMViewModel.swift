//
//  IconographySectionCRMViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionCRMViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper
    
    // MARK: - Properties
    
    let name: String
    let itemViewModels: [[IconographyItemViewModel]]
    
    // MARK: - Initialization
    
    init(iconography: IconographyCRM) {
        self.name = "crm"
        self.itemViewModels = [
            [
                .init(name: "wallet", iconographyImage: iconography.wallet),
                .init(name: "card", iconographyImage: iconography.card)
            ]
        ]
    }
}
