//
//  TextFieldGetBorderLayoutUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

// sourcery: AutoMockable
protocol TextFieldGetBorderLayoutUseCasable {
    func execute(theme: Theme,
                 borderStyle: TextFieldBorderStyle,
                 isFocused: Bool) -> TextFieldBorderLayout
}

final class TextFieldGetBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasable {
    func execute(theme: Theme,
                 borderStyle: TextFieldBorderStyle,
                 isFocused: Bool) -> TextFieldBorderLayout {
        switch borderStyle {
        case .none:
            return .init(
                radius: theme.border.radius.none,
                width: theme.border.width.none
            )
        case .roundedRect:
            return .init(
                radius: theme.border.radius.large,
                width: isFocused ? theme.border.width.medium : theme.border.width.small
            )
        }
    }
}
