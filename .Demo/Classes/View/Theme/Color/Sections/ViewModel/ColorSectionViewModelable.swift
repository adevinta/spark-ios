//
//  ColorSectionViewModelable.swift
//  SparkDemo
//
//  Created by robin.lemaire on 13/03/2023.
//

import SparkCore
import Foundation

protocol ColorSectionViewModelable: Hashable {
    var name: String { get }
    var itemViewModels: [[ColorItemViewModel]] { get }
}
