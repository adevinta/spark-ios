//
//  DimsViewModel.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct DimsViewModel {

    // MARK: - Properties

    func dimItemViewModels(for theme: Theme) -> [DimItemViewModel] {
        [
            .init(name: "dim1", value: theme.dims.dim1),
            .init(name: "dim2", value: theme.dims.dim2),
            .init(name: "dim3", value: theme.dims.dim3),
            .init(name: "dim4", value: theme.dims.dim4),
            .init(name: "dim5", value: theme.dims.dim5),
        ]
    }
}
