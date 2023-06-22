//
//  SwitchPosition.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchPositionable {
    var isToggleOnLeft: Bool { get }
    var horizontalSpacing: CGFloat { get }
}

struct SwitchPosition: SwitchPositionable {

    // MARK: - Properties

    let isToggleOnLeft: Bool
    let horizontalSpacing: CGFloat
}
