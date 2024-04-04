//
//  CheckboxAccessibilityIdentifier.swift
//  SparkCore
//
//  Created by michael.zimmermann on 15.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The accessibility identifiers for the checkbox.
public enum CheckboxAccessibilityIdentifier {
    /// The default accessibility identifier. Can be changed by the consumer
    public static let checkbox = "spark-check-box"
    /// The default accessibility identifier. Can be changed by the consumer
    public static let checkboxGroup = "spark-check-box-group"
    /// The identifier of checkbox group ui view title
    public static let checkboxGroupTitle = "spark-check-box-group-title"
}

public enum CheckboxAccessibilityValue {
    public static let ticked = "1"
    public static let unticked = "0"
}
