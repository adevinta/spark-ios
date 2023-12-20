//
//  TextLinkGetTypographiesUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetTypographiesUseCaseable {

    // sourcery: theme = "Identical"
    func execute(typography: TextLinkTypography,
                 theme: any Theme) -> TextLinkTypographies
}

struct TextLinkGetTypographiesUseCase: TextLinkGetTypographiesUseCaseable {

    // MARK: - Methods

    func execute(
        typography: TextLinkTypography,
        theme: any Theme
    ) -> TextLinkTypographies {
        switch typography {
        case .display1:
            return .init(
                normal: theme.typography.display1,
                highlight: theme.typography.display1
            )
        case .display2:
            return .init(
                normal: theme.typography.display2,
                highlight: theme.typography.display2
            )
        case .display3:
            return .init(
                normal: theme.typography.display3,
                highlight: theme.typography.display3
            )

        case .headline1:
            return .init(
                normal: theme.typography.headline1,
                highlight: theme.typography.headline1
            )
        case .headline2:
            return .init(
                normal: theme.typography.headline2,
                highlight: theme.typography.headline2
            )

        case .subhead:
            return .init(
                normal: theme.typography.subhead,
                highlight: theme.typography.subhead
            )

        case .body1:
            return .init(
                normal: theme.typography.body1,
                highlight: theme.typography.body1Highlight
            )
        case .body2:
            return .init(
                normal: theme.typography.body2,
                highlight: theme.typography.body2Highlight
            )

        case .caption:
            return .init(
                normal: theme.typography.caption,
                highlight: theme.typography.captionHighlight
            )

        case .small:
            return .init(
                normal: theme.typography.small,
                highlight: theme.typography.smallHighlight
            )

        case .callout:
            return .init(
                normal: theme.typography.callout,
                highlight: theme.typography.callout
            )
        }
    }
}
