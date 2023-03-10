//
//  IconographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographyViewModel {

    // MARK: - Properties

    let sectionViewModels: [IconographySectionViewModel]

    // MARK: - Initialization

    init() {
        let iconographies = CurrentTheme.part.iconography
        self.sectionViewModels = [
            .init(name: "Account",
                  itemViewModels: [
                    .init(name: "bank - fill", iconographyImage: iconographies.account.bank.fill),
                    .init(name: "bank - outlined", iconographyImage: iconographies.account.bank.outlined),

                    .init(name: "holiday - fill", iconographyImage: iconographies.account.holiday.fill),
                    .init(name: "holiday - outlined", iconographyImage: iconographies.account.holiday.outlined),
                  ])
        ]
    }
}
