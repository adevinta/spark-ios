//
//  Colors.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - Colors

public protocol Colors {
    var primary: ColorsPrimary { get }
    var secondary: ColorsSecondary { get }
    var base: ColorsBase { get }
    var feedback: ColorsFeedback { get }
    var states: ColorsStates { get }
}

// MARK: - Token

public protocol ColorToken {
    var uiColor: UIColor { get }
    var swiftUIColor: Color { get }
}

public extension ColorToken {
    static var clear: ColorToken {
        return ColorTokenClear()
    }
}

fileprivate struct ColorTokenClear: ColorToken {
    var uiColor: UIColor { .clear }
    var swiftUIColor: Color { .clear }
}
