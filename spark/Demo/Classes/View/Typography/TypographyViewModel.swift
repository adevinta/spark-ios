//
//  TypographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct TypographyViewModel {

    // MARK: - Properties

    let itemViewModels: [[TypographyItemViewModel]]

    // MARK: - Initialization

    init() {
        let typographies = CurrentTheme.part.typography
        self.itemViewModels = [
            [
                .init(name: "display1", typographyFont: typographies.display1),
                .init(name: "display2", typographyFont: typographies.display2),
                .init(name: "display3", typographyFont: typographies.display3)
            ],
            [
                .init(name: "headline1", typographyFont: typographies.headline1),
                .init(name: "headline2", typographyFont: typographies.headline2)
            ],
            [
                .init(name: "subhead", typographyFont: typographies.subhead)
            ],
            [
                .init(name: "body1", typographyFont: typographies.body1),
                .init(name: "body1Highlight", typographyFont: typographies.body1Highlight),
                .init(name: "body2", typographyFont: typographies.body2),
                .init(name: "body2Highlight", typographyFont: typographies.body2Highlight)
            ],
            [
                .init(name: "caption", typographyFont: typographies.caption),
                .init(name: "captionHighlight", typographyFont: typographies.captionHighlight)
            ],
            [
                .init(name: "small", typographyFont: typographies.small),
                .init(name: "smallHighlight", typographyFont: typographies.smallHighlight)
            ],
            [
                .init(name: "callout", typographyFont: typographies.callout)
            ]
        ]
    }
}
