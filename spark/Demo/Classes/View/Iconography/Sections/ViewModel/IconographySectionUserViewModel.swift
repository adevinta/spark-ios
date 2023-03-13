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
            Helper.makeFillAndOutlineViewModels(name: "verified", iconography: iconography.verified),
            Helper.makeFillAndOutlineViewModels(name: "warningSecurity", iconography: iconography.warningSecurity),
            Helper.makeFillAndOutlineViewModels(name: "security", iconography: iconography.security),
            Helper.makeFillAndOutlineViewModels(name: "profile", iconography: iconography.profile),
            Helper.makeFillAndOutlineViewModels(name: "securityProfile", iconography: iconography.securityProfile),
            Helper.makeFillAndOutlineViewModels(name: "securityProfile2", iconography: iconography.securityProfile2),
            Helper.makeFillAndOutlineViewModels(name: "userCheck", iconography: iconography.userCheck),
            Helper.makeFillAndOutlineViewModels(name: "account", iconography: iconography.account),
            Helper.makeFillAndOutlineViewModels(name: "pro", iconography: iconography.pro),
            Helper.makeFillAndOutlineViewModels(name: "group", iconography: iconography.group)
        ]
    }
}
