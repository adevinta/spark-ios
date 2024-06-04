//
//  ColorViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark

struct ColorViewModel {

    // MARK: - Properties

    func sectionViewModels(for theme: Theme) -> [any ColorSectionViewModelable] {
        return ColorSectionType.allCases.map { $0.viewModel(for: theme) }
    }
}
