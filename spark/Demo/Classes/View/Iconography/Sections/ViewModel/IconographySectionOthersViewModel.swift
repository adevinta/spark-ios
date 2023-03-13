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
            Helper.makeFillAndOutlineViewModels(name: "megaphone", iconography: iconography.megaphone),
            Helper.makeFillAndOutlineViewModels(name: "speedmeter", iconography: iconography.speedmeter),
            Helper.makeFillAndOutlineViewModels(name: "dissatisfied", iconography: iconography.dissatisfied),
            Helper.makeFillAndOutlineViewModels(name: "flag", iconography: iconography.flag),
            Helper.makeFillAndOutlineViewModels(name: "satisfied", iconography: iconography.satisfied),
            Helper.makeFillAndOutlineViewModels(name: "neutral", iconography: iconography.neutral),
            Helper.makeFillAndOutlineViewModels(name: "sad", iconography: iconography.sad),
            Helper.makeFillAndOutlineViewModels(name: "fire", iconography: iconography.fire),
            [
                .init(name: "euro", iconographyImage: iconography.euro),
                .init(name: "refund", iconographyImage: iconography.refund),
                .init(name: "sun", iconographyImage: iconography.sun)
            ]
        ]
    }
}
