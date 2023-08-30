//
//  TabsGetAttributesUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol TabsGetAttributesUseCaseable {
    func execute(theme: Theme) -> TabsAttributes
}

struct TabsGetAttributesUseCase {
    func execute(theme: Theme) -> TabsAttributes {
        return TabsAttributes(
            lineHeight: theme.border.width.small,
            lineColor: theme.colors.base.outline)
    }
}
