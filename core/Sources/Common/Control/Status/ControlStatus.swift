//
//  ControlStatus.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The current status of the control: highlighted or not, disabled or not and selected or not.
final class ControlStatus: Equatable {

    // MARK: - Properties

    /// A Boolean value indicating whether the control draws a highlight.
    var isHighlighted: Bool
    /// A Boolean value indicating whether the control is in the enabled state.
    var isEnabled: Bool
    /// A Boolean value indicating whether the control is in the selected state.
    var isSelected: Bool

    // MARK: - Initialization

    init(
        isHighlighted: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false
    ) {
        self.isHighlighted = isHighlighted
        self.isEnabled = isEnabled
        self.isSelected = isSelected
    }

    // MARK: - Equatable

    static func == (lhs: ControlStatus, rhs: ControlStatus) -> Bool {
        return lhs.isHighlighted == rhs.isHighlighted &&
        lhs.isEnabled == rhs.isEnabled &&
        lhs.isSelected == rhs.isSelected
    }
}
