//
//  ButtonState.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 08.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Buttons can have different control states.
public enum ButtonState: Equatable {
    /// The enabled state is the default interactive state.
    case enabled

    /// Disabled buttons are greyed out and user interaction is disabled.
    case disabled
}
