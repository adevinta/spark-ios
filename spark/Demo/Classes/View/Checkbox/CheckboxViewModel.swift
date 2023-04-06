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
    let states: [SparkCheckboxState] = [.enabled, .disabled, .focused, .hover, .pressed, .success, .warning, .error]

    // MARK: - Initialization

    init() {}
}
