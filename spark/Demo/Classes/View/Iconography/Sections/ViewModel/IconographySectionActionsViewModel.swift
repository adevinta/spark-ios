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
            Helper.makeFillAndOutlineViewModels(name: "calculate", iconography: iconography.calculate),
            Helper.makeFillAndOutlineViewModels(name: "copy", iconography: iconography.copy),
            Helper.makeFillAndOutlineViewModels(name: "eye", iconography: iconography.eye),
            Helper.makeFillAndOutlineViewModels(name: "eyeOff", iconography: iconography.eyeOff),
            Helper.makeFillAndOutlineViewModels(name: "like", iconography: iconography.like),
            Helper.makeVerticalAndHorizontalViewModels(name: "moreMenu", iconography: iconography.moreMenu),
            Helper.makeFillAndOutlineViewModels(name: "pen", iconography: iconography.pen),
            Helper.makeFillAndOutlineViewModels(name: "print", iconography: iconography.print),
            Helper.makeFillAndOutlineViewModels(name: "trash", iconography: iconography.trash),
            Helper.makeFillAndOutlineViewModels(name: "trashClose", iconography: iconography.trashClose),
            Helper.makeFillAndOutlineViewModels(name: "wheel", iconography: iconography.wheel),
            Helper.makeFillAndOutlineViewModels(name: "flashlight", iconography: iconography.flashlight),
            Helper.makeFillAndOutlineViewModels(name: "pause", iconography: iconography.pause),
            Helper.makeFillAndOutlineViewModels(name: "play", iconography: iconography.play),
            [
                .init(name: "refresh", iconographyImage: iconography.refresh),
                .init(name: "search", iconographyImage: iconography.search),
                .init(name: "scan", iconographyImage: iconography.scan),
                .init(name: "filter", iconographyImage: iconography.filter)
            ]
        ]
    }
}
