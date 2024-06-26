//
//  PopoverIntent.swift
//  Spark
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

/// Intent used to { get set } background & foreground colors on the popover
public enum PopoverIntent: CaseIterable {
    case surface
    case main
    case support
    case accent
    case basic
    case success
    case alert
    case error
    case info
    case neutral

    internal var getColorsUseCase: PopoverGetColorsUseCasable {
        return PopoverGetColorsUseCase()
    }

    internal func getColors(theme: Theme, getColorsUseCase: PopoverGetColorsUseCasable) -> PopoverColors {
        return getColorsUseCase.execute(colors: theme.colors, intent: self)
    }

    /// Get the colors to apply on popovers from an intent
    /// - Parameters:
    ///   - theme: Spark theme
    /// - Returns: PopoverColors
    public func getColors(theme: Theme) -> PopoverColors {
        return self.getColors(theme: theme, getColorsUseCase: self.getColorsUseCase)
    }
}
