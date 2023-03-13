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
            Helper.makeFillAndOutlineViewModels(name: "alarmOn", iconography: iconography.alarmOn),
            Helper.makeFillAndOutlineViewModels(name: "alarmOff", iconography: iconography.alarmOff),
            Helper.makeFillAndOutlineViewModels(name: "alarm", iconography: iconography.alarm),
            Helper.makeFillAndOutlineViewModels(name: "notification", iconography: iconography.notification)
        ]
    }
}
