//
//  LayoutViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct LayoutViewModel {

    // MARK: - Properties

    func spacingItemViewModels() -> [LayoutSpacingItemViewModel] {
        let layout = SparkTheme.shared.layout

        return [
            .init(name: "none", value: layout.spacing.none),
            .init(name: "small", value: layout.spacing.small),
            .init(name: "medium", value: layout.spacing.medium),
            .init(name: "large", value: layout.spacing.large),
            .init(name: "xLarge", value: layout.spacing.xLarge),
            .init(name: "xxLarge", value: layout.spacing.xxLarge)
        ]
    }
}
