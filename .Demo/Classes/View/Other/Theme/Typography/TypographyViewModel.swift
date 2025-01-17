//
//  TypographyViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


struct TypographyViewModel {

    func itemViewModels() -> [[TypographyItemViewModel]] {
        let typographies = SparkTheme.shared.typography
        return [
            [
                .init(name: "display1", token: typographies.display1),
                .init(name: "display2", token: typographies.display2),
                .init(name: "display3", token: typographies.display3)
            ],
            [
                .init(name: "headline1", token: typographies.headline1),
                .init(name: "headline2", token: typographies.headline2)
            ],
            [
                .init(name: "subhead", token: typographies.subhead)
            ],
            [
                .init(name: "body1", token: typographies.body1),
                .init(name: "body1Highlight", token: typographies.body1Highlight),
                .init(name: "body2", token: typographies.body2),
                .init(name: "body2Highlight", token: typographies.body2Highlight)
            ],
            [
                .init(name: "caption", token: typographies.caption),
                .init(name: "captionHighlight", token: typographies.captionHighlight)
            ],
            [
                .init(name: "small", token: typographies.small),
                .init(name: "smallHighlight", token: typographies.smallHighlight)
            ],
            [
                .init(name: "callout", token: typographies.callout)
            ]
        ]
    }
}
