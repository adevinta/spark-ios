//
//  ButtonAccessibilityIdentifier.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The accessibility identifiers for the button.
public enum ButtonAccessibilityIdentifier {

    // MARK: - Properties

    /// The default view accessibility identifier. Can be changed by the consumer
    @available(*, deprecated, message: "Use button or iconButton key instead")
    public static let view = "spark-button"
    /// The default view accessibility identifier. Can be changed by the consumer
    public static let button = "spark-button"
    /// The default icon button view accessibility identifier. Can be changed by the consumer
    public static let iconButton = "spark-icon-button"
    /// The default content stackView accessibility identifier.
    static let contentStackView = "spark-button-content-stackView"
    /// The icon view accessibility identifier.
    @available(*, deprecated, message: "Use imageContentView key instead")
    public static let icon = "spark-button-icon"
    /// The icon view accessibility identifier.
    public static let imageContentView = "spark-button-image-contentView"
    /// The icon image accessibility identifier.
    @available(*, deprecated, message: "Use imageView key instead")
    public static let iconImage = "spark-button-icon-image"
    /// The icon image accessibility identifier.
    public static let imageView = "spark-button-image"
    /// The text accessibility identifier.
    public static let text = "spark-button-text"
    /// The default clear button accessibility identifier.
    static let clearButton = "spark-button-clear-button"
}
