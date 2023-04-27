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
    let states: [SelectButtonState] = [.enabled, .disabled, .success(message: "Test"), .warning(message: "test"), .error(message: "Error message")]

    // MARK: - Initialization

    init() {}
}
