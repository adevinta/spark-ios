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
    var textColor: any ColorToken { get }
    var checkboxTintColor: any ColorToken { get }
    var checkboxIconColor: any ColorToken { get }
    var pressedBorderColor: any ColorToken { get }
}

struct CheckboxColors: CheckboxColorables {
    let textColor: any ColorToken
    let checkboxTintColor: any ColorToken
    let checkboxIconColor: any ColorToken
    let pressedBorderColor: any ColorToken
}
