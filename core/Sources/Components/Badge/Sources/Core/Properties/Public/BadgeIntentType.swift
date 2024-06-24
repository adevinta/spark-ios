//
//  BadgeIntentType.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
/// **BadgeIntentType** defines color of ``BadgeView``
public enum BadgeIntentType: CaseIterable {
    case accent
    case basic
    case alert
    case danger
    case info
    case neutral
    case main
    case support
    case success
}
