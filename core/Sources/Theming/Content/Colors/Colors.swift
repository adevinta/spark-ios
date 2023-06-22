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

// sourcery: AutoMockable
public protocol Colors {
    var primary: ColorsPrimary { get }
    var secondary: ColorsSecondary { get }
    var base: ColorsBase { get }
    var feedback: ColorsFeedback { get }
    var states: ColorsStates { get }
}

// MARK: - Token

// sourcery: AutoMockable
public protocol ColorToken {
    var uiColor: UIColor { get }
    var color: Color { get }
}

public extension ColorToken {
    static var clear: ColorToken {
        return ColorTokenClear()
    }
}

fileprivate struct ColorTokenClear: ColorToken {
    var uiColor: UIColor { .clear }
    var color: Color { .clear }
}

public extension ColorToken {

    @available(*, deprecated, message: "Use FullColorToken instead")
    func opacity(_ opacity: CGFloat) -> ColorToken {
        return OpacityColorToken(uiColor: self.uiColor.withAlphaComponent(opacity),
                                 color: self.color.opacity(opacity))
    }
}

fileprivate struct OpacityColorToken: ColorToken {
    let uiColor: UIColor
    let color: Color
}
