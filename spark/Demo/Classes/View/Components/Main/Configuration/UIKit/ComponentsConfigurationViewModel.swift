//
//  ComponentsConfigurationUIViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import UIKit

struct ComponentsConfigurationUIViewModel {

    // MARK: - Properties

    let itemsViewModel: [ComponentsConfigurationItemUIViewModel]

    // MARK: - Update

    func update(theme: Theme) {
        for viewModel in self.itemsViewModel {
            viewModel.theme = theme
            viewModel.color = theme.colors.main.main.uiColor
        }
    }}
