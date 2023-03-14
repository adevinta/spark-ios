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
            Helper.makeFilledAndOutlineViewModels(name: "bank", iconography: iconography.bank),
            Helper.makeFilledAndOutlineViewModels(name: "holiday", iconography: iconography.holiday),
            Helper.makeFilledAndOutlineViewModels(name: "country", iconography: iconography.country),
            Helper.makeFilledAndOutlineViewModels(name: "home", iconography: iconography.home),
            Helper.makeFilledAndOutlineViewModels(name: "key", iconography: iconography.key),
            Helper.makeFilledAndOutlineViewModels(name: "favorite", iconography: iconography.favorite),
            Helper.makeFilledAndOutlineViewModels(name: "shoppingCart", iconography: iconography.shoppingCart),
            Helper.makeFilledAndOutlineViewModels(name: "store", iconography: iconography.store),
            Helper.makeFilledAndOutlineViewModels(name: "cv", iconography: iconography.cv),
            Helper.makeFilledAndOutlineViewModels(name: "fileOff", iconography: iconography.fileOff),
            Helper.makeFilledAndOutlineViewModels(name: "work", iconography: iconography.work),
            Helper.makeFilledAndOutlineViewModels(name: "card", iconography: iconography.card),
            Helper.makeFilledAndOutlineViewModels(name: "offer", iconography: iconography.offer),
            [
                .init(name: "burgerMenu", iconographyImage: iconography.burgerMenu),
                .init(name: "activity", iconographyImage: iconography.activity),
                .init(name: "listing", iconographyImage: iconography.listing),
                .init(name: "mobileCheck", iconographyImage: iconography.mobileCheck)
            ]
        ]
    }
}
