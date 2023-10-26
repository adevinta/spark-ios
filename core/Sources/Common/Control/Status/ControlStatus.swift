//
//  ControlStatus.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The current status of the control: highlighted or not, disabled or not and selected or not.
struct ControlStatus {

    // MARK: - Properties

    /// A Boolean value indicating whether the control draws a highlight.
    let isHighlighted: Bool
    /// A Boolean value indicating whether the control is in the disabled state.
    let isDisabled: Bool
    /// A Boolean value indicating whether the control is in the selected state.
    let isSelected: Bool

    // MARK: - Initialization

    init(isHighlighted: Bool, isEnabled: Bool, isSelected: Bool) {
        self.isHighlighted = isHighlighted
        self.isDisabled = !isEnabled
        self.isSelected = isSelected
    }
}
