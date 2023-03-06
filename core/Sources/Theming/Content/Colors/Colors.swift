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

// MARK: - ColorToken

public struct ColorToken {

    // MARK: - Properties

    public let enabled: ColorsValue
    public let pressed: ColorsValue
    public let disabled: ColorsValue
    public let on: ColorsValue

    // MARK: - Initialization

    public init(enabled: ColorsValue,
                pressed: ColorsValue,
                disabled: ColorsValue,
                on: ColorsValue) {
        self.enabled = enabled
        self.pressed = pressed
        self.disabled = disabled
        self.on = on
    }
}

// MARK: - Value

public struct ColorsValue {

    // MARK: - Properties

    public let uiColor: UIColor
    public let swiftUIcolor: Color

    // MARK: - Initialization

    public init(uiColor: UIColor,
                swiftUIcolor: Color) {
        self.uiColor = uiColor
        self.swiftUIcolor = swiftUIcolor
    }
}
