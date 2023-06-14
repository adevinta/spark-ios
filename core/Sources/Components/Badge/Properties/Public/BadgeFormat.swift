//
//  BadgeFormat.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Protocol that defines custom behaviour of ``BadgeView`` text
/// Create your own implementation of badge text by using it
public protocol BadgeFormatting {
    func formatText(for value: Int?) -> String
}

/// With this formatter you can define behaviour of Badge label.
/// available formats:
/// - ``default``
/// - ``overflowCounter(maxValue:)``
/// - ``custom(formatter:)``
public enum BadgeFormat {

    // MARK: - Properties

    /// Use **default** for regular counting behavior with numbers.
    case `default`

    /// Use **overflowCounter(maxValue)**
    /// If badge **value** would be greater than passed **maxValue** into formatter
    /// then badge will show **maxValue+**
    case overflowCounter(maxValue: Int)

    /// You can define your custom behavior by using **custom** type. But in that case
    /// Formatter should be implemented and conform to **BadgeFormatting** protocol
    /// For example you can define thousand counter to show 96k instead of 96000
    case custom(formatter: BadgeFormatting)

    // MARK: - Getting text

    /// This function will return text value for your badge
    /// wiht conformation to the selected **BadgeFormat** type
    func text(_ value: Int?) -> String {
        switch self {
        case .overflowCounter(let maxValue):
            guard let value else {
                return ""
            }
            return value > maxValue ? "\(maxValue)+" : "\(value)"
        case .custom(let formatter):
            return formatter.formatText(for: value)
        default:
            guard let value else {
                return ""
            }
            return "\(value)"
        }
    }
}
