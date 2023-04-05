//
//  TypographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore

struct CheckboxViewModel {

    // MARK: - Properties

    let variants: [SparkTagVariant] = [.filled, .outlined, .tinted]
    let colors: [SparkCheckboxIntentColor] = [.neutral]

    // MARK: - Initialization

    init() {}
}
