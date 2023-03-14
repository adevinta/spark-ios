//
//  IconographySectionViewModelable.swift
//  SparkDemo
//
//  Created by robin.lemaire on 13/03/2023.
//

import SparkCore
import Foundation

protocol IconographySectionViewModelable: Hashable {
    var name: String { get }
    var itemViewModels: [[IconographyItemViewModel]] { get }
}
