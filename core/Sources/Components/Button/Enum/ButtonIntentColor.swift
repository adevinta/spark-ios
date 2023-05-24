//
//  ButtonIntentColor.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// A button intent is used to apply a color scheme to a button.
@frozen
public enum ButtonIntentColor {
    /// Intent used for warning-feedback.
    case alert

    /// Intent used for error-feedback.
    case danger

    /// Intent used for neutral-feedback.
    case neutral

    /// Defines a primary button with primary colors.
    case primary

    /// Defines a secondary button with secondary colors.
    case secondary

    /// Intent used for success-feedback.
    case success

    /// Intent used for surface-buttons.
    case surface
}
