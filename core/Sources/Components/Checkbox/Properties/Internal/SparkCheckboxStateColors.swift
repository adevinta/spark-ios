//
//  SparkCheckboxStateColors.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol SparkCheckboxStateColorables {
    var textColor: ColorToken { get }
    var checkboxColor: ColorToken { get }
    var checkboxIconColor: ColorToken { get }
}

struct SparkCheckboxStateColors: SparkCheckboxStateColorables {

    // MARK: - Properties

    let textColor: ColorToken
    let checkboxColor: ColorToken
    let checkboxIconColor: ColorToken
}
