//
//  ButtonGetCornerRadiusUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetCornerRadiusUseCaseable {
    func execute(forShape shape: ButtonShape,
                 border: Border,
                 variant: ButtonVariant) -> ButtonBorderProtocol
}

struct ButtonGetCornerRadiusUseCase: ButtonGetCornerRadiusUseCaseable {

    // MARK: - Methods

    func execute(
        forShape shape: ButtonShape,
        border: Border,
        variant: ButtonVariant
    ) -> ButtonBorderProtocol {
        let radius: CGFloat
        switch shape {
        case .square:
            radius = 0
        case .rounded:
            radius = border.radius.large
        case .pill:
            radius = border.radius.full
        }

        let width = (variant == .outlined) ? border.width.small : 0

        return ButtonBorder(
            width: width,
            radius: radius
        )
    }
}
