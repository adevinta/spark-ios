//
//  ColorsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

public struct ColorsDefault: Colors {

    // MARK: - Properties

    public let primary: ColorsPrimary
    public let secondary: ColorsSecondary
    public let base: ColorsBase
    public let feedback: ColorsFeedback
    public let states: ColorsStates

    // MARK: - Initialization

    public init(primary: ColorsPrimary,
                secondary: ColorsSecondary,
                base: ColorsBase,
                feedback: ColorsFeedback,
                states: ColorsStates) {
        self.primary = primary
        self.secondary = secondary
        self.base = base
        self.feedback = feedback
        self.states = states
    }
}

// MARK: - Token

public struct ColorTokenDefault: ColorToken {

    // MARK: - Properties

    public let uiColor: UIColor
    public let color: Color

    // MARK: - Initialization

    public init(named colorName: String, in bundle: Bundle) {
        guard let uiColor = UIColor(named: colorName, in: bundle, compatibleWith: nil) else {
            fatalError("Missing color asset named \(colorName) in bundle \(bundle.bundleIdentifier ?? bundle.description)")
        }
        self.uiColor = uiColor
        self.color = Color(colorName, bundle: bundle)
    }

    // MARK: - Internal init

    init(color: Color, uiColor: UIColor) {
        self.uiColor = uiColor
        self.color = color
    }
}
