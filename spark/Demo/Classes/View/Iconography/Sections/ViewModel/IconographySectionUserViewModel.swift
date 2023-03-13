//
//  IconographySectionUserViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionUserViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyUser) {
        self.name = "user"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "verified", iconography: iconography.verified),
            Helper.makeFilledAndOutlineViewModels(name: "warningSecurity", iconography: iconography.warningSecurity),
            Helper.makeFilledAndOutlineViewModels(name: "security", iconography: iconography.security),
            Helper.makeFilledAndOutlineViewModels(name: "profile", iconography: iconography.profile),
            Helper.makeFilledAndOutlineViewModels(name: "securityProfile", iconography: iconography.securityProfile),
            Helper.makeFilledAndOutlineViewModels(name: "securityProfile2", iconography: iconography.securityProfile2),
            Helper.makeFilledAndOutlineViewModels(name: "userCheck", iconography: iconography.userCheck),
            Helper.makeFilledAndOutlineViewModels(name: "account", iconography: iconography.account),
            Helper.makeFilledAndOutlineViewModels(name: "pro", iconography: iconography.pro),
            Helper.makeFilledAndOutlineViewModels(name: "group", iconography: iconography.group)
        ]
    }
}
