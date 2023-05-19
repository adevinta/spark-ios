//
//  ButtonColorables.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol ButtonColorables {
    var textColor: ColorToken { get }
    var backgroundColor: ColorToken { get }
    var pressedBackgroundColor: ColorToken { get }
    var borderColor: ColorToken { get }
    var pressedBorderColor: ColorToken { get }
}

struct ButtonColors: ButtonColorables {

    // MARK: - Properties

    let textColor: ColorToken
    let backgroundColor: ColorToken
    let pressedBackgroundColor: ColorToken
    let borderColor: ColorToken
    let pressedBorderColor: ColorToken
}
