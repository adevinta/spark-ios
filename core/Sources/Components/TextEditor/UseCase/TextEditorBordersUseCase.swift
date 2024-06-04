//
//  TextEditorBordersUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 27.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TextEditorBordersUseCasable {
    func execute(theme: Theme, intent: TextEditorIntent, isFocused: Bool) -> TextEditorBorders
}

final class TextEditorBordersUseCase: TextEditorBordersUseCasable {
    func execute(
        theme: Theme,
        intent: TextEditorIntent,
        isFocused: Bool) -> TextEditorBorders {

        let radious = theme.border.radius.large
        let width: CGFloat

        if intent == .neutral, !isFocused {
            width = theme.border.width.small
        } else {
            width = theme.border.width.medium
        }

        return .init(
            radius: radious,
            width: width
        )
    }
}
