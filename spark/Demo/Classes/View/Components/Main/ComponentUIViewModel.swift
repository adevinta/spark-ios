//
//  ComponentUIViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol ComponentUIViewModel {
    var identifier: String { get }
    var configurationViewModel: ComponentsConfigurationUIViewModel { get }
}
