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
    func execute(theme: Theme,
                 intent: TabIntent,
                 state: TabState,
                 size: TabSize) -> TabStateAttributes
}

/// TabGetStateAttributesUseCase
/// Use case to determine the attributes of the Tab
/// Functions:
/// - execute: returns attributes for given theme, intent and state
struct TabGetStateAttributesUseCase: TabGetStateAttributesUseCasable {

    private let getIntentColorUseCase: any TabGetIntentColorUseCaseble
    private let getFontUseCase: any TabGetFontUseCaseable

    // MARK: - Initializer
    init(getIntentColorUseCase: any TabGetIntentColorUseCaseble = TabGetIntentColorUseCase(),
         getTabFontUseCase: any TabGetFontUseCaseable = TabGetFontUseCase()
    ) {
        self.getIntentColorUseCase = getIntentColorUseCase
        self.getFontUseCase = getTabFontUseCase
    }

    // MARK: - Functions
    ///
    /// Calculate the attribute of the tab depending on the theme, intent and state
    ///
    /// - Parameters:
    ///    - theme: current theme
    ///    - intent: `TabIntent`.
    ///    - state: `TabState`.
    ///    - size: `TabSize`
    ///
    /// - Returns: ``TabStateAttributes`` return attributes of the tab.
    func execute(theme: Theme,
                 intent: TabIntent,
                 state: TabState,
                 size: TabSize) -> TabStateAttributes {

        let font = self.getFontUseCase.execute(typography: theme.typography, size: size)

        let spacings = TabItemSpacings(
            verticalEdge: theme.layout.spacing.medium,
            horizontalEdge: theme.layout.spacing.large,
            content: theme.layout.spacing.medium
        )

        let colors = TabItemColors(
            label: theme.colors.base.onSurface,
            line: theme.colors.base.outline,
            background: theme.colors.base.surface
        )

        if state.isDisabled {
            return TabStateAttributes(
                spacings: spacings,
                colors: colors,
                opacity: theme.dims.dim3,
                separatorLineHeight: theme.border.width.small,
                font: font
            )
        }

        if state.isPressed {
            return TabStateAttributes(
                spacings: spacings,
                colors: colors,
                opacity: nil,
                separatorLineHeight: theme.border.width.small,
                font: font
            )
        }

        if state.isSelected {
            let intentColor = self.getIntentColorUseCase.execute(colors: theme.colors, intent: intent)
            let selectedColors = TabItemColors(
                label: intentColor,
                line: intentColor,
                background: theme.colors.base.surface
            )
            return TabStateAttributes(
                spacings: spacings,
                colors: selectedColors,
                opacity: nil,
                separatorLineHeight: theme.border.width.medium,
                font: font
            )
        }

        return TabStateAttributes(
            spacings: spacings,
            colors: colors,
            opacity: nil,
            separatorLineHeight: theme.border.width.small,
            font: font
        )
    }
}

