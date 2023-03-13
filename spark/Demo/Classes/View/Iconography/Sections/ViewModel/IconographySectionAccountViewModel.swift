//
//  IconographySectionAccountViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionAccountViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyAccount) {
        self.name = "account"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "bank", iconography: iconography.bank),
            Helper.makeFillAndOutlineViewModels(name: "holiday", iconography: iconography.holiday),
            Helper.makeFillAndOutlineViewModels(name: "country", iconography: iconography.country),
            Helper.makeFillAndOutlineViewModels(name: "home", iconography: iconography.home),
            Helper.makeFillAndOutlineViewModels(name: "key", iconography: iconography.key),
            Helper.makeFillAndOutlineViewModels(name: "favorite", iconography: iconography.favorite),
            Helper.makeFillAndOutlineViewModels(name: "shoppingCart", iconography: iconography.shoppingCart),
            Helper.makeFillAndOutlineViewModels(name: "store", iconography: iconography.store),
            Helper.makeFillAndOutlineViewModels(name: "cv", iconography: iconography.cv),
            Helper.makeFillAndOutlineViewModels(name: "fileOff", iconography: iconography.fileOff),
            Helper.makeFillAndOutlineViewModels(name: "work", iconography: iconography.work),
            Helper.makeFillAndOutlineViewModels(name: "card", iconography: iconography.card),
            Helper.makeFillAndOutlineViewModels(name: "offer", iconography: iconography.offer),
            [
                .init(name: "burgerMenu", iconographyImage: iconography.burgerMenu),
                .init(name: "activity", iconographyImage: iconography.activity),
                .init(name: "listing", iconographyImage: iconography.listing),
                .init(name: "mobileCheck", iconographyImage: iconography.mobileCheck)
            ]
        ]
    }
}
