//
//  BorderViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct BorderViewModel {

    // MARK: - Properties

    let sectionViewModels: [BorderSectionViewModel]

    // MARK: - Initialization

    init() {
        let border = CurrentTheme.part.border
        self.sectionViewModels = [
            .init(name: "none width",
                  itemViewModels: [
                    .init(name: "none", width: border.width.none, radius: border.radius.none),
                    .init(name: "small", width: border.width.none, radius: border.radius.small),
                    .init(name: "medium", width: border.width.none, radius: border.radius.medium),
                    .init(name: "large", width: border.width.none, radius: border.radius.large),
                    .init(name: "xLarge", width: border.width.none, radius: border.radius.xLarge)
                  ]),

                .init(name: "small width",
                      itemViewModels: [
                        .init(name: "none", width: border.width.small, radius: border.radius.none),
                        .init(name: "small", width: border.width.small, radius: border.radius.small),
                        .init(name: "medium", width: border.width.small, radius: border.radius.medium),
                        .init(name: "large", width: border.width.small, radius: border.radius.large),
                        .init(name: "xLarge", width: border.width.small, radius: border.radius.xLarge)
                      ]),

                .init(name: "medium width",
                      itemViewModels: [
                        .init(name: "none", width: border.width.medium, radius: border.radius.none),
                        .init(name: "small", width: border.width.medium, radius: border.radius.small),
                        .init(name: "medium", width: border.width.medium, radius: border.radius.medium),
                        .init(name: "large", width: border.width.medium, radius: border.radius.large),
                        .init(name: "xLarge", width: border.width.medium, radius: border.radius.xLarge)
                      ])
        ]
    }
}
