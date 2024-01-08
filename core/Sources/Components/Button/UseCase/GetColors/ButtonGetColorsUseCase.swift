//
//  ButtonColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 19.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetColorsUseCaseable {
    func execute(theme: some Theme,
                 intent: ButtonIntent,
                 variant: ButtonVariant) -> ButtonColors
}

struct ButtonGetColorsUseCase: ButtonGetColorsUseCaseable {

    // MARK: - Private properties

    private let getContrastUseCase: any ButtonGetVariantUseCaseable
    private let getFilledUseCase: any ButtonGetVariantUseCaseable
    private let getGhostUseCase: any ButtonGetVariantUseCaseable
    private let getOutlinedUseCase: any ButtonGetVariantUseCaseable
    private let getTintedUseCase: any ButtonGetVariantUseCaseable

    // MARK: - Initialization

    init(
        getContrastUseCase: some ButtonGetVariantUseCaseable = ButtonVariantGetContrastUseCase(),
        getFilledUseCase: some ButtonGetVariantUseCaseable = ButtonGetVariantFilledUseCase(),
        getGhostUseCase: some ButtonGetVariantUseCaseable = ButtonGetVariantGhostUseCase(),
        getOutlinedUseCase: some ButtonGetVariantUseCaseable = ButtonGetVariantOutlinedUseCase(),
        getTintedUseCase: some ButtonGetVariantUseCaseable = ButtonGetVariantTintedUseCase()
    ) {
        self.getContrastUseCase = getContrastUseCase
        self.getFilledUseCase = getFilledUseCase
        self.getGhostUseCase = getGhostUseCase
        self.getOutlinedUseCase = getOutlinedUseCase
        self.getTintedUseCase = getTintedUseCase
    }

    // MARK: - Methods
    func execute(
        theme: some Theme,
        intent: ButtonIntent,
        variant: ButtonVariant
    ) -> ButtonColors {
        let colors = theme.colors
        let dims = theme.dims

        let useCase: any ButtonGetVariantUseCaseable
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
        
        return useCase.execute(
            intent: intent,
            colors: colors,
            dims: dims
        )
    }
}
