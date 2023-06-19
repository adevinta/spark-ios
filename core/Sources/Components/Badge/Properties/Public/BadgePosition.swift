//
//  BadgePosition.swift
//  SparkCore
//
//  Created by louis.borlee on 16/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Enum that represents the position where the ``BadgeView`` can be attached on another view
///
/// There are two possible positions:
/// - topTrailingCorner
/// - trailing
public enum BadgePosition: CaseIterable {
    case topTrailingCorner
    case trailing
}
