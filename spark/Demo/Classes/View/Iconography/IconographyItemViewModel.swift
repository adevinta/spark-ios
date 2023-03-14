//
//  IconographyItemViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore
import SwiftUI

struct IconographyItemViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let image: Image

    // MARK: - Initialization

    init(name: String,
         iconographyImage: IconographyImage) {
        self.name = name
        self.image = iconographyImage.swiftUIImage
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
