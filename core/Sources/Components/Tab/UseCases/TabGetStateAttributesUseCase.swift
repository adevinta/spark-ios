//
//  TabGetStateAttributesUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TabGetStateAttributesUseCasable {
    func execute(theme: Theme, intent: TabIntent, state: TabState) -> TabStateAttributes
}

/// TabGetStateAttributesUseCase
/// Use case to determine the attributes of the Tab
/// Functions:
/// - execute: returns attributes for given theme, intent and state
struct TabGetStateAttributesUseCase: TabGetStateAttributesUseCasable {

    // MARK: - Functions
    ///
    /// Calculate the attribute of the tab depending on the theme, intent and state
    ///
    /// - Parameters:
    ///    - theme: current theme
    ///    - intent: `TabIntent`.
    ///    - state: `TabState`.
    ///
    /// - Returns: ``TabStateAttributes`` return attributes of the tab.
    func execute(theme: Theme, intent: TabIntent, state: TabState) -> TabStateAttributes {
        return self.execute(theme: theme, intent: intent, state: state, tabGetColorUseCase: TabGetIntentColorUseCase())
    }
    
    func execute(
        theme: Theme,
        intent: TabIntent,
        state: TabState,
        tabGetColorUseCase: any TabGetIntentColorUseCaseble
    ) -> TabStateAttributes {
        
        if state.isDisabled {
            return TabStateAttributes(
                label: theme.colors.base.outline,
                line: theme.colors.base.outline,
                background: theme.colors.base.surface,
                opacity: theme.dims.dim3,
                lineHeight: theme.border.width.small
            )
        }
        
        if state.isPressed {
            return TabStateAttributes(
                label: theme.colors.base.outline,
                line: theme.colors.base.outline,
                background: theme.colors.base.surface,
                opacity: nil,
                lineHeight: theme.border.width.small
            )
        }
        
        if state.isSelected {
            var intentColor = tabGetColorUseCase.execute(colors: theme.colors, intent: intent)
            return TabStateAttributes(
                label: intentColor,
                line: intentColor,
                background: theme.colors.base.surface,
                opacity: nil,
                lineHeight: theme.border.width.medium
            )
        }
       
        return TabStateAttributes(
            label: theme.colors.base.outline,
            line: theme.colors.base.outline,
            background: theme.colors.base.surface,
            opacity: nil,
            lineHeight: theme.border.width.small
        )
    }
}
