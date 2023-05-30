//
//  ButtonVariant.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// A button variant is used to distinguish between different design and appearance options.
public enum ButtonVariant {
    /// A filled button with a solid background.
    case filled

    /// A transparent button with an outline-border.
    case outlined

    /// A tinted button with a solid background.
    case tinted

    /// A ghost button with no background at all.
    case ghost

    /// A contrast button with a solid background for better readability.
    case contrast
}
