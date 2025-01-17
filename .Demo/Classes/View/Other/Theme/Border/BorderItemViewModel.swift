//
//  BorderItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct BorderItemViewModel: Hashable {

    // MARK: - Properties

    let contentHeight: CGFloat
    let name: String
    let description: String
    let width: CGFloat
    let radius: CGFloat

    // MARK: - Initialization

    init(name: String,
         width: CGFloat,
         radius: CGFloat) {
        self.contentHeight = radius.isFinite && !radius.isZero ? radius * 4 : 50
        self.name = name + " radius"
        let radiusValueDescription = radius.isFinite ? "\(Int(radius))px" : "half"
        self.description = "width: \(Int(width))px - radius: \(radiusValueDescription)"
        self.width = width
        self.radius = radius
    }
}
