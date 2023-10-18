//
//  ProgressBarShape.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// All ProgressBar variants can have different shapes.
public enum ProgressBarShape: CaseIterable, Equatable {
    /// ProgressBar with pill-like shape.
    case pill
    /// Square button with no rounded corners.
    case square
}
