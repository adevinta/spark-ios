//
//  ComponentsConfigurationItemUIType.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

enum ComponentsConfigurationItemUIType: Equatable {
    case button
    case toggle(isOn: Bool)
    case checkbox(title: String, isOn: Bool)
    case rangeSelector(selected: Int, range: CountableClosedRange<Int>)
}
