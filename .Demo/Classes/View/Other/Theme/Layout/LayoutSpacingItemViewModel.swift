//
//  LayoutSpacingItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct LayoutSpacingItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let description: String
    let value: CGFloat

    // MARK: - Initialization

    init(name: String,
         value: CGFloat) {
        self.name = name
        self.description = "\(Int(value))px"
        self.value = value
    }
}
