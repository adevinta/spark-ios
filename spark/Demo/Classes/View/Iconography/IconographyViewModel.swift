//
//  IconographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographyViewModel {

    // MARK: - Properties

    let sectionViewModels: [any IconographySectionViewModelable] = IconographySectionType.allCases.map { $0.viewModel }
}
