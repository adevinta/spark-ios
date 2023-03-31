//
//  ColorItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct ColorItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let color: Color

    // MARK: - Initialization

    init(name: String,
         colorToken: ColorToken) {
        self.name = name
        self.color = colorToken.color
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
