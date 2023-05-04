//
//  TagComponentFrameworkViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct TagComponentFrameworkViewModel: Hashable {

    // MARK: - Properties

    let name: String
    let sectionViewModels: [TagComponentSectionViewModel]

    // MARK: - Initialization

    init(isSwiftUIComponent: Bool) {
        self.name = isSwiftUIComponent ? "SwiftUI" : "UIKit"
        self.sectionViewModels = [
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .alert
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .danger
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .info
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .neutral
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .primary
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .secondary
            ),
            .init(
                isSwiftUIComponent: isSwiftUIComponent,
                intentColor: .success
            )
        ]
    }
}
