//
//  IconographySectionOthersViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionOthersViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyOthers) {
        self.name = "others"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "megaphone", iconography: iconography.megaphone),
            Helper.makeFilledAndOutlineViewModels(name: "speedmeter", iconography: iconography.speedmeter),
            Helper.makeFilledAndOutlineViewModels(name: "dissatisfied", iconography: iconography.dissatisfied),
            Helper.makeFilledAndOutlineViewModels(name: "flag", iconography: iconography.flag),
            Helper.makeFilledAndOutlineViewModels(name: "satisfied", iconography: iconography.satisfied),
            Helper.makeFilledAndOutlineViewModels(name: "neutral", iconography: iconography.neutral),
            Helper.makeFilledAndOutlineViewModels(name: "sad", iconography: iconography.sad),
            Helper.makeFilledAndOutlineViewModels(name: "fire", iconography: iconography.fire),
            [
                .init(name: "euro", iconographyImage: iconography.euro),
                .init(name: "refund", iconographyImage: iconography.refund),
                .init(name: "sun", iconographyImage: iconography.sun)
            ]
        ]
    }
}
