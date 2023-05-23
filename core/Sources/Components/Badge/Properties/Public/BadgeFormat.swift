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
///
/// Use **default** for regular counting behavior with numbers.
///
/// Use **overflowCounter(maxValue)**
/// If badge **value** would be greater than passed **maxValue** into formatter
/// then badge will show **maxValue+**
///
/// You can define your custom behavior by using **custom** type. But in that case
/// Fromatter should be implemented and conform to **BadgeFormatting** protocol
/// For example you can define thouthand counter to show 96k instead of 96000
///
/// To get text you need to call **badgeText(value) -> String** function
public enum BadgeFormat {

    // MARK: - Properties

    case `default`
    case overflowCounter(maxValue: Int)
    case custom(formatter: BadgeFormatting)

    // MARK: - Getting text

    func badgeText(_ value: Int?) -> String {
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
