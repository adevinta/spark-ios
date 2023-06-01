//
//  ButtonColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 19.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetColorsUseCaseable {
    func execute(from theme: Theme, intentColor: ButtonIntentColor, variant: ButtonVariant) -> ButtonColorables
}

struct ButtonGetColorsUseCase: ButtonGetColorsUseCaseable {

    // MARK: - Private properties

    private let filledUseCase: ButtonVariantUseCaseable
    private let outlinedUseCase: ButtonVariantUseCaseable
    private let tintedUseCase: ButtonVariantUseCaseable
    private let ghostUseCase: ButtonVariantUseCaseable
    private let contrastUseCase: ButtonVariantUseCaseable

    // MARK: - Initialization

    init(
        filledUseCase: ButtonVariantUseCaseable = ButtonVariantFilledUseCase(),
        outlinedUseCase: ButtonVariantUseCaseable = ButtonVariantOutlinedUseCase(),
        tintedUseCase: ButtonVariantUseCaseable = ButtonVariantTintedUseCase(),
        ghostUseCase: ButtonVariantUseCaseable = ButtonVariantGhostUseCase(),
        contrastUseCase: ButtonVariantUseCaseable = ButtonVariantContrastUseCase()
    ) {
        self.filledUseCase = filledUseCase
        self.outlinedUseCase = outlinedUseCase
        self.tintedUseCase = tintedUseCase
        self.ghostUseCase = ghostUseCase
        self.contrastUseCase = contrastUseCase
    }

    // MARK: - Methods
    func execute(
        from theme: Theme,
        intentColor: ButtonIntentColor,
        variant: ButtonVariant
    ) -> ButtonColorables {
        let colors = theme.colors
        let dims = theme.dims
        let useCase: ButtonVariantUseCaseable
        switch variant {
        case .filled:
            useCase = self.filledUseCase
        case .outlined:
            useCase = self.outlinedUseCase
        case .tinted:
            useCase = self.tintedUseCase
        case .ghost:
            useCase = self.ghostUseCase
        case .contrast:
            useCase = self.contrastUseCase
        }
        return useCase.colors(for: intentColor, on: colors, dims: dims)
    }
}
