//
//  SparkCheckboxColorables.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol SparkCheckboxColorables {
    var backgroundColor: ColorToken { get }
    var borderColor: ColorToken? { get }
    var foregroundColor: ColorToken { get }
    var textColor: ColorToken { get }
    var checkboxTintColor: ColorToken { get }
}

struct SparkCheckboxColors: SparkCheckboxColorables {
    let backgroundColor: ColorToken
    let borderColor: ColorToken?
    let foregroundColor: ColorToken
    let textColor: ColorToken
    let checkboxTintColor: ColorToken
}
