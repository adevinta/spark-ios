//
//  SparkCheckboxTheming.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct SparkCheckboxTheming {

    // MARK: - Properties

    let theme: Theme
    let variant: SparkTagVariant

    // MARK: - Initialization

    public init(theme: Theme, variant: SparkTagVariant) {
        self.theme = theme
        self.variant = variant
    }
}
