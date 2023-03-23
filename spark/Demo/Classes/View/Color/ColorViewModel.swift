//
//  ColorViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct ColorViewModel {

    // MARK: - Properties

    let sectionViewModels: [any ColorSectionViewModelable] = ColorSectionType.allCases.map { $0.viewModel }
}
