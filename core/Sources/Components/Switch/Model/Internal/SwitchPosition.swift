//
//  SwitchPosition.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchPosition {
    var isToggleOnLeft: Bool { get }
    var horizontalSpacing: CGFloat { get }
}

struct SwitchPositionDefault: SwitchPosition {

    // MARK: - Properties

    let isToggleOnLeft: Bool
    let horizontalSpacing: CGFloat
}
