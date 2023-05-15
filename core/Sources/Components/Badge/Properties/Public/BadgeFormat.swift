//
//  BadgeFormat.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol BadgeFormatting {
    func formatText(for value: Int?) -> String
}

public enum BadgeFormat {

    // MARK: - Properties

    case standart
    case overflowCounter(maxValue: Int)
    case custom(formatter: BadgeFormatting)

    // MARK: - Getting text

    func badgeText(_ value: Int?) -> String {
        switch self {
        case .standart:
            guard let value else {
                return ""
            }
            return "\(value)"
        case .overflowCounter(let maxValue):
            guard let value else {
                return ""
            }
            return value > maxValue ? "\(maxValue)+" : "\(value)"
        case .custom(let formatter):
            return formatter.formatText(for: value)
        }
    }
}
