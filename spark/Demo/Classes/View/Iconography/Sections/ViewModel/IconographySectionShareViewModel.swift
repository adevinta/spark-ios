//
//  IconographySectionShareViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionShareViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyShare) {
        self.name = "share"
        self.itemViewModels = [
            [
                .init(name: "import", iconographyImage: iconography.import),
                .init(name: "export", iconographyImage: iconography.export)
            ],

            Helper.makeFilledAndOutlineViewModels(name: "facebook", iconography: iconography.facebook),
            Helper.makeFilledAndOutlineViewModels(name: "twitter", iconography: iconography.twitter),
            Helper.makeFilledAndOutlineViewModels(name: "share", iconography: iconography.share),

            [
                .init(name: "attachFile", iconographyImage: iconography.attachFile),
                .init(name: "link", iconographyImage: iconography.link)
            ],

            Helper.makeFilledAndOutlineViewModels(name: "forward", iconography: iconography.forward),
            Helper.makeFilledAndOutlineViewModels(name: "instagram", iconography: iconography.instagram),

            [
                .init(name: "messenger", iconographyImage: iconography.messenger),
                .init(name: "pinterest", iconographyImage: iconography.pinterest),
                .init(name: "whastapp", iconographyImage: iconography.whastapp),
                .init(name: "expand", iconographyImage: iconography.expand),
                .init(name: "shareIOS", iconographyImage: iconography.shareIOS)
            ]
        ]
    }
}
