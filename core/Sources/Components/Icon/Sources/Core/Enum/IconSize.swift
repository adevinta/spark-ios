//
//  IconSize.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Different sizes of icon.
public enum IconSize: CaseIterable {
    /// Small icon with size of 16x16px
    case small

    /// Small icon with size of 24x24px
    case medium

    /// Small icon with size of 32x32px
    case large

    /// Small icon with size of 40x40px
    case extraLarge
}

// MARK: - Extension
extension IconSize {
    public var value: CGFloat {
        switch self {
        case .small:
            return Constants.valueSmall
        case .medium:
            return Constants.valueMedium
        case .large:
            return Constants.valueLarge
        case .extraLarge:
            return Constants.valueExtraLarge
        }
    }
}

// MARK: - Constants
private enum Constants {
    static var valueSmall: CGFloat = 16
    static var valueMedium: CGFloat = 24
    static var valueLarge: CGFloat = 32
    static var valueExtraLarge: CGFloat = 40
}
