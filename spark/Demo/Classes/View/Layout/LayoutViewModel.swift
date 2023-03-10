//
//  LayoutViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct LayoutViewModel {

    // MARK: - Properties

    let spacingItemViewModels: [LayoutSpacingItemViewModel]

    // MARK: - Initialization

    init() {
        let layout = CurrentTheme.part.layout

        self.spacingItemViewModels = [
            .init(name: "none", value: layout.spacing.none),
            .init(name: "small", value: layout.spacing.small),
            .init(name: "medium", value: layout.spacing.medium),
            .init(name: "large", value: layout.spacing.large),
            .init(name: "xLarge", value: layout.spacing.xLarge),
            .init(name: "xxLarge", value: layout.spacing.xxLarge)
        ]
    }
}
