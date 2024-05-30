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
    /// The default checkbox accessibility identifier.
    public static let checkbox = "spark-check-box"
    /// The default checkbox group accessibility identifier.
    public static let checkboxGroup = "spark-check-box-group"
    /// The identifier of checkbox group ui view title
    public static let checkboxGroupTitle = "spark-check-box-group-title"
    /// The default checkbox group item accessibility identifier.
    public static func checkboxGroupItem(_ id: String) -> String {
        Self.checkbox + "-\(id)"
    }
}

public enum CheckboxAccessibilityValue {
    public static let checked = "1"
    public static let indeterminate = "0.5"
    public static let unchecked = "0"
}
