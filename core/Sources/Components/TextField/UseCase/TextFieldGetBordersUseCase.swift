//
//  TextFieldGetBordersUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol TextFieldGetBordersUseCasable {
    func execute(theme: Theme,
                 borderStyle: TextFieldBorderStyle) -> TextFieldBorders
}

final class TextFieldGetBordersUseCase: TextFieldGetBordersUseCasable {
    func execute(theme: Theme,
                 borderStyle: TextFieldBorderStyle) -> TextFieldBorders {
        switch borderStyle {
        case .none:
            return .init(
                radius: .zero,
                width: .zero
            )
        case .roundedRect:
            return .init(
                radius: theme.border.radius.large,
                width: theme.border.width.small
            )
        }
    }
}
