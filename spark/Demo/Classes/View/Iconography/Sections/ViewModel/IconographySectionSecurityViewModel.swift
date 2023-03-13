//
//  IconographySectionSecurityViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionSecurityViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper
    
    // MARK: - Properties
    
    let name: String
    let itemViewModels: [[IconographyItemViewModel]]
    
    // MARK: - Initialization
    
    init(iconography: IconographySecurity) {
        self.name = "security"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "idea", iconography: iconography.idea),
            Helper.makeFillAndOutlineViewModels(name: "lock", iconography: iconography.lock),
            Helper.makeFillAndOutlineViewModels(name: "unlock", iconography: iconography.unlock)
        ]
    }
}
