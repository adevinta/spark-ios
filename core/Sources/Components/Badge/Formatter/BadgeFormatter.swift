//
//  BadgeFormatter.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol BadgeFormatting {
    func badgeText(value: String?) -> String
}

/// With this formatter you can define behaviour of Badge label.
///
/// Use **standart** for regular counting behavior with numbers.
/// If there would be more than 99 notifications -- it will show 99+
///
/// **Thousands** counter allows you to use counting for bigger numbers: 35k -> 35000
///
/// You can defune your custom behavior by using **custom** type. But in that case
/// Fromatter should be implemented and conform to **BadgeFormatting** protocol
public enum BadgeFormatter {
    case standart
    case thousandsCounter
    case custom(formatter: BadgeFormatting)
}
