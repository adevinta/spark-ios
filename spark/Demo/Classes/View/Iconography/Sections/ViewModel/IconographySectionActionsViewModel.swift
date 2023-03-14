//
//  IconographySectionActionsViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionActionsViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyActions) {
        self.name = "actions"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "calculate", iconography: iconography.calculate),
            Helper.makeFilledAndOutlineViewModels(name: "copy", iconography: iconography.copy),
            Helper.makeFilledAndOutlineViewModels(name: "eye", iconography: iconography.eye),
            Helper.makeFilledAndOutlineViewModels(name: "eyeOff", iconography: iconography.eyeOff),
            Helper.makeFilledAndOutlineViewModels(name: "like", iconography: iconography.like),
            Helper.makeVerticalAndHorizontalViewModels(name: "moreMenu", iconography: iconography.moreMenu),
            Helper.makeFilledAndOutlineViewModels(name: "pen", iconography: iconography.pen),
            Helper.makeFilledAndOutlineViewModels(name: "print", iconography: iconography.print),
            Helper.makeFilledAndOutlineViewModels(name: "trash", iconography: iconography.trash),
            Helper.makeFilledAndOutlineViewModels(name: "trashClose", iconography: iconography.trashClose),
            Helper.makeFilledAndOutlineViewModels(name: "wheel", iconography: iconography.wheel),
            Helper.makeFilledAndOutlineViewModels(name: "flashlight", iconography: iconography.flashlight),
            Helper.makeFilledAndOutlineViewModels(name: "pause", iconography: iconography.pause),
            Helper.makeFilledAndOutlineViewModels(name: "play", iconography: iconography.play),
            [
                .init(name: "refresh", iconographyImage: iconography.refresh),
                .init(name: "search", iconographyImage: iconography.search),
                .init(name: "scan", iconographyImage: iconography.scan),
                .init(name: "filter", iconographyImage: iconography.filter)
            ]
        ]
    }
}
