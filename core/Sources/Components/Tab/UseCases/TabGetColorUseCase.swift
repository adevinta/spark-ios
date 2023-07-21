//
//  TabGetColorUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TabGetColorUseCasable {
    func execute(colors: any Colors, intent: TabIntent) -> any ColorToken
}

/// TabGetColorUseCase
/// Use case to determin the colors of the Tab by the intent
/// Functions:
/// - execute: returns a color token for given colors and an intent
struct TabGetColorUseCase: TabGetColorUseCasable {

    // MARK: - Functions
    ///
    /// Calculate the color of the tab depending on the intent
    ///
    /// - Parameters:
    ///    - colors: Colors from the theme
    ///    - intent: `TabIntent`.
    ///
    /// - Returns: ``ColorToken`` return color of the tab.
    func execute(colors: any Colors, intent: TabIntent) -> any ColorToken {
        switch intent {
        case .primary: return colors.primary.primary
        case .secondary: return colors.secondary.secondary
        }
    }
}