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
            Helper.makeFillAndOutlineViewModels(name: "voice", iconography: iconography.voice),
            Helper.makeFillAndOutlineViewModels(name: "voiceOff", iconography: iconography.voiceOff),
            Helper.makeFillAndOutlineViewModels(name: "mail", iconography: iconography.mail),
            Helper.makeFillAndOutlineViewModels(name: "mailActif", iconography: iconography.mailActif),
            Helper.makeFillAndOutlineViewModels(name: "typing", iconography: iconography.typing),
            Helper.makeFillAndOutlineViewModels(name: "message", iconography: iconography.message),
            Helper.makeFillAndOutlineViewModels(name: "conversation", iconography: iconography.conversation),
            [
                .init(name: "phone", iconographyImage: iconography.phone),
                .init(name: "call", iconographyImage: iconography.call),
                .init(name: "support", iconographyImage: iconography.support),
                .init(name: "support2", iconographyImage: iconography.support2)
            ]
        ]
    }
}
