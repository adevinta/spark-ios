//
//  Colors.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public protocol Colors {
    var primary: ColorToken { get }
    var primaryVariant: ColorToken { get }

    var secondary: ColorToken { get }
    var secondaryVariant: ColorToken { get }

    var background: ColorToken { get }

    var surface: ColorToken { get }
    var surfaceInverse: ColorToken { get }

    var success: ColorToken { get }
    var alert: ColorToken { get }
    var error: ColorToken { get }
    var info: ColorToken { get }
    var neutral: ColorToken { get }

    var primaryContainer: ColorToken { get }
    var secondaryContainer: ColorToken { get }
    var successContainer: ColorToken { get }
    var alertContainer: ColorToken { get }
    var errorContainer: ColorToken { get }
    var infoContainer: ColorToken { get }
    var neutralContainer: ColorToken { get }
}

// MARK: - Token

public protocol ColorToken {
    var enabled: ColorTokenValue { get }
    var pressed: ColorTokenValue { get }
    var disabled: ColorTokenValue { get }
    var on: ColorTokenValue { get }
}

// MARK: - Value

public protocol ColorTokenValue {
    var uiColor: UIColor { get }
    var swiftUIColor: Color { get }
}
