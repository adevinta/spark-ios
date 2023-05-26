//
//  TagComponentSectionViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct TagComponentSectionViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [TagComponentItemViewModel]

    // MARK: - Initialization

    init(isSwiftUIComponent: Bool,
         intentColor: TagIntentColor) {
        self.name = "\(intentColor)"
        self.itemViewModels = [
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: intentColor,
                variant: .filled
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: intentColor,
                variant: .outlined
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: intentColor,
                variant: .tinted
            )
        ]
    }
}
