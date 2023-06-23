//
//  ButtonColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 19.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// TODO: recheck all colors on variants UC

// sourcery: AutoMockable
protocol ButtonGetColorsUseCaseable {
    func execute(forTheme theme: Theme, intentColor: ButtonIntentColor, variant: ButtonVariant) -> ButtonColorables
}

struct ButtonGetColorsUseCase: ButtonGetColorsUseCaseable {

    // MARK: - Private properties

    private let getContrastUseCase: ButtonGetVariantUseCaseable
    private let getFilledUseCase: ButtonGetVariantUseCaseable
    private let getGhostUseCase: ButtonGetVariantUseCaseable
    private let getOutlinedUseCase: ButtonGetVariantUseCaseable
    private let getTintedUseCase: ButtonGetVariantUseCaseable

    // MARK: - Initialization

    init(
        getContrastUseCase: ButtonGetVariantUseCaseable = ButtonVariantGetContrastUseCase(),
        getFilledUseCase: ButtonGetVariantUseCaseable = ButtonGetVariantFilledUseCase(),
        getGhostUseCase: ButtonGetVariantUseCaseable = ButtonGetVariantGhostUseCase(),
        getOutlinedUseCase: ButtonGetVariantUseCaseable = ButtonGetVariantOutlinedUseCase(),
        getTintedUseCase: ButtonGetVariantUseCaseable = ButtonGetVariantTintedUseCase()
    ) {
        self.getContrastUseCase = getContrastUseCase
        self.getFilledUseCase = getFilledUseCase
        self.getGhostUseCase = getGhostUseCase
        self.getOutlinedUseCase = getOutlinedUseCase
        self.getTintedUseCase = getTintedUseCase
    }

    // MARK: - Methods
    func execute(
        forTheme theme: Theme,
        intentColor: ButtonIntentColor,
        variant: ButtonVariant
    ) -> ButtonColorables {
        let colors = theme.colors
        let dims = theme.dims

        let useCase: ButtonGetVariantUseCaseable
        switch variant {
        case .contrast:
            useCase = self.getContrastUseCase
        case .filled:
            useCase = self.getFilledUseCase
        case .ghost:
            useCase = self.getGhostUseCase
        case .outlined:
            useCase = self.getOutlinedUseCase
        case .tinted:
            useCase = self.getTintedUseCase
        }
        
        return useCase.colors(
            forIntentColor: intentColor,
            colors: colors,
            dims: dims
        )
    }
}
