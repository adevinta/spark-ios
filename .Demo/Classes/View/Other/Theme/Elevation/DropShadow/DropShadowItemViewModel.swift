//
//  DropShadowItemViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct DropShadowItemViewModel: Identifiable {

    let id = UUID()

    let name: String
    let description: String
    let shadow: ElevationShadow

    init(name: String,
         shadow: ElevationShadow) {
        self.name = name
        self.description =
        """
        offset: \(shadow.offset)
        blur: \(shadow.blur)
        opacity: \(shadow.opacity)
        """
        self.shadow = shadow
    }
}
