//
//  CheckboxStateColors.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol CheckboxStateColorables {
    var textColor: ColorToken { get }
    var checkboxColor: ColorToken { get }
    var checkboxIconColor: ColorToken { get }
    var pressedBorderColor: ColorToken { get }
}

struct CheckboxStateColors: CheckboxStateColorables {

    // MARK: - Properties

    let textColor: ColorToken
    let checkboxColor: ColorToken
    let checkboxIconColor: ColorToken
    let pressedBorderColor: ColorToken
}
