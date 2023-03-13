//
//  IconographySectionContactViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionContactViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyContact) {
        self.name = "contact"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "voice", iconography: iconography.voice),
            Helper.makeFilledAndOutlineViewModels(name: "voiceOff", iconography: iconography.voiceOff),
            Helper.makeFilledAndOutlineViewModels(name: "mail", iconography: iconography.mail),
            Helper.makeFilledAndOutlineViewModels(name: "mailActif", iconography: iconography.mailActif),
            Helper.makeFilledAndOutlineViewModels(name: "typing", iconography: iconography.typing),
            Helper.makeFilledAndOutlineViewModels(name: "message", iconography: iconography.message),
            Helper.makeFilledAndOutlineViewModels(name: "conversation", iconography: iconography.conversation),
            [
                .init(name: "phone", iconographyImage: iconography.phone),
                .init(name: "call", iconographyImage: iconography.call),
                .init(name: "support", iconographyImage: iconography.support),
                .init(name: "support2", iconographyImage: iconography.support2)
            ]
        ]
    }
}
