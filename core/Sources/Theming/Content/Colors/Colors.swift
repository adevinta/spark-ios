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
public protocol ColorToken: Hashable, Equatable {
    var uiColor: UIColor { get }
    var color: Color { get }
}

// Hashable & Equatable
public extension ColorToken {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.color)
        hasher.combine(self.uiColor)
    }

    static func == (lhs: any ColorToken, rhs: any ColorToken) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public extension ColorToken {
    static var clear: any ColorToken {
        return ColorTokenClear()
    }
}

fileprivate struct ColorTokenClear: ColorToken {
    var uiColor: UIColor { .clear }
    var color: Color { .clear }
}

public extension ColorToken {

    func opacity(_ opacity: CGFloat) -> any ColorToken {
        return OpacityColorToken(colorToken: self,
                                 opacity: opacity)
    }
}

fileprivate struct OpacityColorToken: ColorToken {
    static func == (lhs: OpacityColorToken, rhs: OpacityColorToken) -> Bool {
        return lhs.hashValue == rhs.hashValue && lhs.opacity == rhs.opacity
    }

    let colorToken: any ColorToken
    let opacity: CGFloat

    var uiColor: UIColor {
        return self.colorToken.uiColor.withAlphaComponent(self.opacity)
    }
    var color: Color {
        return self.colorToken.color.opacity(self.opacity)
    }
}
