//
//  IconographySectionTransactionViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionTransactionViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyTransaction) {
        self.name = "transaction"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "carWarranty", iconography: iconography.carWarranty),
            Helper.makeFillAndOutlineViewModels(name: "piggyBank", iconography: iconography.piggyBank),
            Helper.makeFillAndOutlineViewModels(name: "money", iconography: iconography.money)
        ]
    }
}
