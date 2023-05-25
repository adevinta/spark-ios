//
//  ButtonSize.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Buttons come in different heights.
public enum ButtonSize {
    /// A small button with a base height of 32 points.
    case small

    /// A medium button with a base height of 44 points.
    case medium

    /// A large button with a base height of 56 points.
    case large
}

// MARK: - Internal extension
extension ButtonSize {
    var height: CGFloat {
        switch self {
        case .small:
            return Constants.heightSmall
        case .medium:
            return Constants.heightMedium
        case .large:
            return Constants.heightLarge
        }
    }
}

// MARK: - Constants
private enum Constants {
    static var heightSmall: CGFloat = 32
    static var heightMedium: CGFloat = 44
    static var heightLarge: CGFloat = 56
}
