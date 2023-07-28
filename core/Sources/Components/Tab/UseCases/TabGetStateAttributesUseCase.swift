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

    private let getIntentColorUseCase: any TabGetIntentColorUseCaseble

    // MARK: - Initializer
    init(getIntentColorUseCase: any TabGetIntentColorUseCaseble = TabGetIntentColorUseCase()) {
        self.getIntentColorUseCase = getIntentColorUseCase
    }

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
    func execute(theme: Theme,
                 intent: TabIntent,
                 state: TabState) -> TabStateAttributes {
        
        let spacings = TabItemSpacings(
            verticalSpacing: theme.layout.spacing.medium,
            horizontalSpacing: theme.layout.spacing.large,
            horizontalPadding: theme.layout.spacing.medium
        )
        
        let colors = TabItemColors(
            labelColor: theme.colors.base.outline,
            lineColor: theme.colors.base.outline,
            backgroundColor: theme.colors.base.surface
        )

        
        if state.isDisabled {
            return TabStateAttributes(
                spacings: spacings,
                colors: colors,
                opacity: theme.dims.dim3,
                separatorLineHeight: theme.border.width.small
            )
        }
        
        if state.isPressed {
            return TabStateAttributes(
                spacings: spacings,
                colors: colors,
                opacity: nil,
                separatorLineHeight: theme.border.width.small
            )
        }
        
        if state.isSelected {
            let intentColor = self.getIntentColorUseCase.execute(colors: theme.colors, intent: intent)
            let selectedcolors = TabItemColors(
                labelColor: intentColor,
                lineColor: intentColor,
                backgroundColor: theme.colors.base.surface
            )
            return TabStateAttributes(
                spacings: spacings,
                colors: selectedcolors,
                opacity: nil,
                separatorLineHeight: theme.border.width.medium
            )
        }
        
        return TabStateAttributes(
            spacings: spacings,
            colors: colors,
            opacity: nil,
            separatorLineHeight: theme.border.width.small
        )
    }
}
