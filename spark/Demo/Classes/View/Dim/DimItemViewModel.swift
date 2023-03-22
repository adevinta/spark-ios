//
//  DimItemViewModel.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct DimItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let description: String
    let value: CGFloat

    // MARK: - Initialization

    init(name: String,
         value: CGFloat) {
        self.name = name
        self.description = "opacity \(Int(value * 100))%"
        self.value = value
    }
}
