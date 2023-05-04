//
//  CheckboxColorables.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol CheckboxColorables {
    var textColor: ColorToken { get }
    var checkboxTintColor: ColorToken { get }
    var checkboxIconColor: ColorToken { get }
    var pressedBorderColor: ColorToken { get }
}

struct CheckboxColors: CheckboxColorables {
    let textColor: ColorToken
    let checkboxTintColor: ColorToken
    let checkboxIconColor: ColorToken
    let pressedBorderColor: ColorToken
}
