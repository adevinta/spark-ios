//
//  ControlState.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Constants describing the state of a Spark control.
public enum ControlState: CaseIterable {
    /// The normal, or default, state of a control where the control is enabled but neither selected nor highlighted.
    case normal
    /// The highlighted state of a control.
    case highlighted
    /// The disabled state of a control.
    case disabled
    /// The selected state of a control.
    case selected
}
