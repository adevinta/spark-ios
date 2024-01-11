//
//  ProgressTrackerState.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

struct ProgressTrackerState: Updateable, Equatable {
    var isEnabled: Bool
    var isPressed: Bool
    var isSelected: Bool

    static var `default` = ProgressTrackerState(isEnabled: true, isPressed: false, isSelected: false)

    var isDisabled: Bool {
        return !self.isEnabled
    }
}
