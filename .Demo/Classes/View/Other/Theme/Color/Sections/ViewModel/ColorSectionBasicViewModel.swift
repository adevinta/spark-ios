//
//  ColorSectionBasicViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


struct ColorSectionBasicViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsBasic) {
        self.name = "Basic"
        self.itemViewModels = [
            [
                .init(name: "basic", colorToken: color.basic),
                .init(name: "onBasic", colorToken: color.onBasic),
                .init(name: "basicContainer", colorToken: color.basicContainer),
                .init(name: "onBasicContainer", colorToken: color.onBasicContainer)
            ]
        ]
    }
}
