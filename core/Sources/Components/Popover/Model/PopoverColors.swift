//
//  PopoverColors.swift
//  Spark
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

public struct PopoverColors {

    /// Popover background color
    public let background: any ColorToken
    /// Popover foreground color
    public let foreground: any ColorToken

    /// PopoverColors init
    /// - Parameters:
    ///   - background: Popover background color
    ///   - foreground: Popover foreground color
    public init(
        background: any ColorToken,
        foreground: any ColorToken
    ) {
        self.background = background
        self.foreground = foreground
    }
}
