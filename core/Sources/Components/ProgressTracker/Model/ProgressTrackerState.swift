//
//  ProgressTrackerState.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkCommon

/// The possible states of the progress tracker
struct ProgressTrackerState: Updateable, Equatable {
    var isEnabled: Bool
    var isPressed: Bool
    var isSelected: Bool

    static var normal = ProgressTrackerState(isEnabled: true, isPressed: false, isSelected: false)

    static var disabled = ProgressTrackerState(isEnabled: false, isPressed: false, isSelected: false)

    static var selected = ProgressTrackerState(isEnabled: true, isPressed: false, isSelected: true)

    static var pressed = ProgressTrackerState(isEnabled: true, isPressed: true, isSelected: false)

    var isDisabled: Bool {
        return !self.isEnabled
    }
}
