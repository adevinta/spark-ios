//
//  TabsGetAttributesUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TabsGetAttributesUseCaseable {
    func execute(theme: Theme, isEnabled: Bool) -> TabsAttributes
}

/// TabGetColorUseCase
/// Use case to determin the colors of the Tab by the intent
/// Functions:
/// - execute: returns a color token for given colors and an intent
struct TabsGetAttributesUseCase: TabsGetAttributesUseCaseable {

    // MARK: - Functions
    ///
    /// Calculate the attributes of the tab control depending on wheter it is enabled or not.
    ///
    /// - Parameters:
    ///    - theme: The theme
    ///    - isEnabled: Bool.
    ///
    /// - Returns: ``TabsAttributes`` containing colors and line hight of the tab control.
    func execute(theme: Theme, isEnabled: Bool) -> TabsAttributes {

        var lineColor = theme.colors.base.outline
        if !isEnabled {
            lineColor = lineColor.opacity(theme.dims.dim3)
        }

        return TabsAttributes(
            lineHeight: theme.border.width.small,
            lineColor: lineColor,
            backgroundColor: theme.colors.base.surface
        )
    }
}
