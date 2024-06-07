//
//  ProgressBarAccessibilityIdentifier.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The accessibility identifiers for the progressBar.
public enum ProgressBarAccessibilityIdentifier {

    // MARK: - Properties

    /// The content view accessibility identifier.
    public static let contentView = "spark-progressBar-contentView"
    /// The progress bar accessibility identifier.
    public static let progressBar = "spark-progress-bar"
    /// The indicator view accessibility identifier.
    public static let indicatorView = "spark-progressBar-indicatorView"
    /// The bottom indicator view accessibility identifier. Only used with progress bar double
    public static let bottomIndicatorView = "spark-progressBar-bottomIndicatorView"
}
