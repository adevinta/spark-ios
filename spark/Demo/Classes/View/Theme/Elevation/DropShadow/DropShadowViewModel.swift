//
//  DropShadowViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Spark

struct DropShadowViewModel {
    let itemViewModels: [DropShadowItemViewModel]

    init(dropShadow: ElevationDropShadows & ElevationShadow = SparkTheme.shared.elevation.dropShadow) {
        self.itemViewModels = [
            .init(name: "none", shadow: dropShadow.none),
            .init(name: "small", shadow: dropShadow.small),
            .init(name: "default", shadow: dropShadow),
            .init(name: "medium", shadow: dropShadow.medium),
            .init(name: "large", shadow: dropShadow.large),
            .init(name: "extraLarge", shadow: dropShadow.extraLarge)
        ]
    }
}
