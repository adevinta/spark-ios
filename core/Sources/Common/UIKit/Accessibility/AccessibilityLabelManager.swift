//
//  AccessibilityLabelManager.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

/// This struct can be implemented in the components that contain at least one subview (label, ...)
///
/// The goal of this struct is to manage the accessibilityLabel of the UIKit component.
/// There is two possibilities.
/// The default one, using the subviews accessibilityLabel, concatenate them to create one accessibilityLabel using by the component.
/// In this case, the accessibilityLabel can change if the subview accessibilityLabel changes.
/// Or,
/// The consumer set a value. In this case, In this case, the accessibilityLabel will always be the one set by the consumer
struct AccessibilityLabelManager {

    // MARK: - Private Properties

    /// A Boolean value indicating whether the consumer set an accessibilityLabel.
    private var isSetExternally = false

    /// A String value indicating the current accessibilityLabel of the component.
    private var _accessibilityLabel: String?

    // MARK: - Properties

    /// A String value indicating whether **the component** set an accessibilityLabel.
    /// When the value changes, the accessibilityLabel can be updated.
    var internalValue: String? {
        didSet {
            self.value = self.internalValue
        }
    }

    /// A String value indicating the current accessibilityLabel of the component.
    var value: String? {
        get {
            return self._accessibilityLabel
        }
        set {
            // If the value is set by the consumer OR if the default value (given by the internalValue) is nil or empty
            if newValue != self.internalValue || self.internalValue.isEmptyOrNil {
                if !newValue.isEmptyOrNil, newValue != self._accessibilityLabel {
                    self._accessibilityLabel = newValue
                } else if newValue != self.internalValue { // Set the value with the internal value
                    self._accessibilityLabel = self.internalValue
                }
                self.isSetExternally = !newValue.isEmptyOrNil

            } else if !self.isSetExternally, newValue != self._accessibilityLabel { // If the value isn't set by the consumer
                self._accessibilityLabel = newValue
            }
        }
    }
}
