//
//  TagComponentViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark

struct TagComponentViewModel {

    // MARK: - Properties

    let frameworkViewModels: [TagComponentFrameworkViewModel]

    // MARK: - Initialization

    init() {
        self.frameworkViewModels = [
            .init(isSwiftUIComponent: true),
            .init(isSwiftUIComponent: false)
        ]
    }
}
