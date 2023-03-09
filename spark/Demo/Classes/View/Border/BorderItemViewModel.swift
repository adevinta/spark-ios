//
//  BorderItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SwiftUI

struct BorderItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let description: String
    let width: CGFloat
    let radius: CGFloat

    // MARK: - Initialization

    init(name: String,
         width: CGFloat,
         radius: CGFloat) {
        self.name = name + " radius"
        self.description = "width: \(Int(width))px - radius: \(Int(radius))px"
        self.width = width
        self.radius = radius
    }
}
