//
//  TextFieldGetSpacingsUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol TextFieldGetSpacingsUseCasable {
    func execute(theme: Theme,
                 borderStyle: TextFieldBorderStyle) -> TextFieldSpacings
}

final class TextFieldGetSpacingsUseCase: TextFieldGetSpacingsUseCasable {
    func execute(theme: Theme, borderStyle: TextFieldBorderStyle) -> TextFieldSpacings {
        switch borderStyle {
        case .none:
            return .init(
                left: .zero,
                content: theme.layout.spacing.medium,
                right: .zero
            )
        case .roundedRect, .line:
            return .init(
                left: theme.layout.spacing.large,
                content: theme.layout.spacing.medium,
                right: theme.layout.spacing.large
            )
        }
    }
}
