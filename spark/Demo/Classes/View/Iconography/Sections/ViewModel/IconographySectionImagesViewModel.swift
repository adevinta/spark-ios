//
//  IconographySectionImagesViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionImagesViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyImages) {
        self.name = "images"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "camera", iconography: iconography.camera),
            Helper.makeFillAndOutlineViewModels(name: "addImage", iconography: iconography.addImage),
            Helper.makeFillAndOutlineViewModels(name: "gallery", iconography: iconography.gallery),
            Helper.makeFillAndOutlineViewModels(name: "add", iconography: iconography.add),
            Helper.makeFillAndOutlineViewModels(name: "image", iconography: iconography.image),
            [
                .init(name: "noPhoto", iconographyImage: iconography.noPhoto),
                .init(name: "rotateImage", iconographyImage: iconography.rotateImage)
            ]
        ]
    }
}
