//
//  IconographySectionNotificationsViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionNotificationsViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyNotifications) {
        self.name = "notifications"
        self.itemViewModels = [
            Helper.makeFilledAndOutlineViewModels(name: "alarmOn", iconography: iconography.alarmOn),
            Helper.makeFilledAndOutlineViewModels(name: "alarmOff", iconography: iconography.alarmOff),
            Helper.makeFilledAndOutlineViewModels(name: "alarm", iconography: iconography.alarm),
            Helper.makeFilledAndOutlineViewModels(name: "notification", iconography: iconography.notification)
        ]
    }
}
