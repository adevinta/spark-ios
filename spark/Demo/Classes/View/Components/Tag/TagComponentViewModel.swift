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

    let sectionViewModels: [TagComponentSectionViewModel]

    // MARK: - Initialization

    init() {
        self.sectionViewModels = [
            .init(intentColor: .alert),
            .init(intentColor: .danger),
            .init(intentColor: .info),
            .init(intentColor: .neutral),
            .init(intentColor: .primary),
            .init(intentColor: .secondary),
            .init(intentColor: .success)
        ]
    }
}
