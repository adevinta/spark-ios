//
//  TagComponentItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore
import Spark

struct TagComponentItemViewModel: Hashable {

    // MARK: - Properties

    let isSwiftUIComponent: Bool
    let name: String
    let intentColor: TagIntentColor
    let variant: TagVariant

    let imageNamed: String = "alert"
    let text: String = "Text"

    // MARK: - Initialization

    init(isSwiftUIComponent: Bool,
         intentColor: TagIntentColor,
         variant: TagVariant) {
        self.isSwiftUIComponent = isSwiftUIComponent
        self.name = ".\(variant) variant / .\(intentColor) intentColor"
        self.intentColor = intentColor
        self.variant = variant
    }
}
