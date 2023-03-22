//
//  DimViewModel.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct DimViewModel {

    // MARK: - Properties

    let dimItemViewModels: [DimItemViewModel]

    // MARK: - Initialization

    init() {
        let dim = CurrentTheme.part.dim

        self.dimItemViewModels = [
            .init(name: "dim1", value: dim.dim1),
            .init(name: "dim2", value: dim.dim2),
            .init(name: "dim3", value: dim.dim3),
            .init(name: "dim4", value: dim.dim4),
            .init(name: "dim5", value: dim.dim5),
        ]
    }
}
