//
//  CheckboxStateColors.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol CheckboxStateColorables {
    var textColor: any ColorToken { get }
    var checkboxColor: any ColorToken { get }
    var checkboxIconColor: any ColorToken { get }
    var pressedBorderColor: any ColorToken { get }
}

struct CheckboxStateColors: CheckboxStateColorables {

    // MARK: - Properties

    let textColor: any ColorToken
    let checkboxColor: any ColorToken
    let checkboxIconColor: any ColorToken
    let pressedBorderColor: any ColorToken
}
