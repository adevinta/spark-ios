//
//  IconographySectionCalendarViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionCalendarViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyCalendar) {
        self.name = "calendar"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "calendar", iconography: iconography.calendar),
            Helper.makeFillAndOutlineViewModels(name: "calendar2", iconography: iconography.calendar2),
            Helper.makeFillAndOutlineViewModels(name: "calendarValid", iconography: iconography.calendarValid)
        ]
    }
}
