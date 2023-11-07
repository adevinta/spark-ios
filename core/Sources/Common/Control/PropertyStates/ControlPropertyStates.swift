//
//  ControlPropertyStates.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Manage all the states for a dynamic property.
final class ControlPropertyStates<PropertyType> {

    // MARK: - Type Alias

    private typealias PropertyState = ControlPropertyState<PropertyType>

    // MARK: - Properties

    private var normalState = PropertyState(for: .normal)
    private var highlightedState = PropertyState(for: .highlighted)
    private var disabledState = PropertyState(for: .disabled)
    private var selectedState = PropertyState(for: .selected)

    // MARK: - Setter

    /// Set the new value for a state.
    /// - Parameters:
    ///   - value: the new value
    ///   - state: the state for the new value
    func setValue(_ value: PropertyType?, for state: ControlState) {
        let propertyState: PropertyState

        switch state {
        case .normal:
            propertyState = self.normalState
        case .highlighted:
            propertyState = self.highlightedState
        case .disabled:
            propertyState = self.disabledState
        case .selected:
            propertyState = self.selectedState
        }

        propertyState.value = value
    }

    // MARK: - Getter

    /// Get the value for a state.
    /// - Parameters:
    ///   - state: the state of the value
    func value(forState state: ControlState) -> PropertyType? {
        switch state {
        case .normal: return self.normalState.value
        case .highlighted: return self.highlightedState.value
        case .disabled: return self.disabledState.value
        case .selected: return self.selectedState.value
        }
    }

    /// Get the value for the status of the control.
    /// - Parameters:
    ///   - status: the status of the control
    func value(forStatus status: ControlStatus) -> PropertyType? {
        // isHighlighted has the highest priority,
        // then isDisabled,
        // then isSelected,
        // and if there is no matching case, we always return the normal value.

        if status.isHighlighted, let value = self.highlightedState.value {
            return value
        } else if status.isDisabled, let value = self.disabledState.value {
            return value
        } else if status.isSelected, let value = self.selectedState.value {
            return value
        } else {
            return self.normalState.value
        }
    }
}
