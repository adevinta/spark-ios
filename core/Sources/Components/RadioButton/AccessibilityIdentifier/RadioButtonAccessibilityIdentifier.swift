//
//  RadioButtonAccessibilityIdentifier.swift
//  SparkCore
//
//  Created by michael.zimmermann on 14.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public enum RadioButtonAccessibilityIdentifier {

    // MARK: - Properties

    public static let radioButton = "spark-radio-button"

    /// The radio group title accessibility identifier.
    public static let radioButtonGroupTitle = "spark-radio-button-group-title"

    public static func radioButtonIdentifier<ID: CustomStringConvertible>(id: ID) -> String {
        return "\(radioButton)-\(id)"
    }
}
