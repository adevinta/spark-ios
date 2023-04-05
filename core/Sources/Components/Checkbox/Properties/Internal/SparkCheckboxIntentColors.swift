//
//  SparkCheckboxIntentColor.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol SparkCheckboxIntentColorables {
    var color: ColorToken { get }
    var onColor: ColorToken { get }
    var containerColor: ColorToken { get }
    var onContainerColor: ColorToken { get }
    var surfaceColor: ColorToken { get }
    var textColor: ColorToken { get }
}

struct SparkCheckboxIntentColors: SparkCheckboxIntentColorables {

    // MARK: - Properties

    let color: ColorToken
    let onColor: ColorToken
    let containerColor: ColorToken
    let onContainerColor: ColorToken
    let surfaceColor: ColorToken
    let textColor: ColorToken
}
