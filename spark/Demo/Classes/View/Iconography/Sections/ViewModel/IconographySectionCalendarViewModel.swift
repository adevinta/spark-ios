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
            Helper.makeFilledAndOutlineViewModels(name: "calendar", iconography: iconography.calendar),
            Helper.makeFilledAndOutlineViewModels(name: "calendar2", iconography: iconography.calendar2),
            Helper.makeFilledAndOutlineViewModels(name: "calendarValid", iconography: iconography.calendarValid)
        ]
    }
}
