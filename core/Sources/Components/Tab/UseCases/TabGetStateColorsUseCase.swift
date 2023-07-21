//
//  TabGetStateColorsUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TabGetStateColorsUseCasable {
    func execute(theme: Theme, intent: TabIntent, state: TabState) -> TabStateColors
}

/// TabGetColorUseCase
/// Use case to determin the colors of the Tab by the intent
/// Functions:
/// - execute: returns a color token for given colors and an intent
struct TabGetStateColorsUseCase: TabGetStateColorsUseCasable {

    // MARK: - Functions
    ///
    /// Calculate the color of the tab depending on the intent
    ///
    /// - Parameters:
    ///    - colors: Colors from the theme
    ///    - intent: `TabIntent`.
    ///
    /// - Returns: ``ColorToken`` return color of the tab.
    func execute(theme: Theme, intent: TabIntent, state: TabState) -> TabStateColors {
        return self.execute(theme: theme, intent: intent, state: state, tabGetColorUseCase: TabGetIntentColorUseCase())
    }
    
    func execute(theme: Theme, intent: TabIntent, state: TabState, tabGetColorUseCase: any TabGetIntentColorUseCaseble) -> TabStateColors {
        switch state {
        case .selected:
            var intentColor = tabGetColorUseCase.execute(colors: theme.colors, intent: intent)
            return TabStateColors(label: intentColor, line: intentColor, background: theme.colors.base.surface, opacity: nil)
        case .pressed:
            return TabStateColors(label: theme.colors.base.outline, line: theme.colors.base.outline, background: theme.colors.base.surface, opacity: nil)
        case .disabled:
            return TabStateColors(label: theme.colors.base.outline, line: theme.colors.base.outline, background: theme.colors.base.surface, opacity: theme.dims.dim3)
        }
        
    }
}
