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
                 tabSize: TabSize,
                 hasTitle: Bool) -> TabStateAttributes
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
                 tabSize: TabSize,
                 hasTitle: Bool
    ) -> TabStateAttributes {

        let size = hasTitle ? tabSize : TabSize.md
        
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

        let heights = TabItemHeights(
            separatorLineHeight: theme.border.width.small,
            itemHeight: size.itemHeight,
            iconHeight: size.iconHeight
        )

        if !state.isEnabled {
            return TabStateAttributes(
                spacings: spacings,
                colors: colors.update(\.opacity, value: theme.dims.dim3),
                heights: heights,
                font: font
            )
        }

        if state.isPressed {
            let pressedColors = TabItemColors(
                label: theme.colors.base.onSurface.opacity(theme.dims.dim1),
                line: theme.colors.base.outline,
                background: theme.colors.states.surfacePressed)

            return TabStateAttributes(
                spacings: spacings,
                colors: pressedColors,
                heights: heights,
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
                heights: heights.update(\.separatorLineHeight, value: theme.border.width.medium),
                font: font
            )
        }

        return TabStateAttributes(
            spacings: spacings,
            colors: colors,
            heights: heights,
            font: font
        )
    }
}

private extension CGFloat {
    static let medium: CGFloat = 40
    static let small: CGFloat = 36
    static let xtraSmall: CGFloat = 34

    static let fontMd: CGFloat = 16
    static let fontSm: CGFloat = 14
    static let fontXs: CGFloat = 12
}

private extension TabSize {
    var itemHeight: CGFloat {
        switch self {
        case .md: return .medium
        case .sm: return .small
        case .xs: return .xtraSmall
        }
    }

    var iconHeight: CGFloat {
        switch self {
        case .md: return .fontMd
        case .sm: return .fontSm
        case .xs: return .fontXs
       }
    }
}
