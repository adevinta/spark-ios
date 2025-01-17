//
//  ColorViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


struct ColorViewModel {

    // MARK: - Properties

    func sectionViewModels() -> [any ColorSectionViewModelable] {
        return ColorSectionType.allCases.map { $0.viewModel() }
    }
}
