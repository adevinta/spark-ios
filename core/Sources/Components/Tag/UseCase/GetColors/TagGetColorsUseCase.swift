//
//  TagGetColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagGetColorsUseCaseable {
    func execute(theme: some Theme,
                 intent: TagIntent,
                 variant: TagVariant) -> TagColors
}

struct TagGetColorsUseCase: TagGetColorsUseCaseable {

    // MARK: - Properties

    private let getContentColorsUseCase: any TagGetContentColorsUseCaseable

    // MARK: - Initialization

    init(getContentColorsUseCase: any TagGetContentColorsUseCaseable = TagGetContentColorsUseCase()) {
        self.getContentColorsUseCase = getContentColorsUseCase
    }

    // MARK: - Methods

    func execute(theme: some Theme,
                 intent: TagIntent,
                 variant: TagVariant) -> TagColors {
        let contentColors = self.getContentColorsUseCase.execute(
            intent: intent,
            colors: theme.colors
        )

        switch variant {
        case .filled:
            return .init(
                backgroundColor: contentColors.color,
                borderColor: contentColors.color,
                foregroundColor: contentColors.onColor
            )

        case .outlined:
            return .init(
                backgroundColor: ColorTokenDefault.clear,
                borderColor: contentColors.color,
                foregroundColor: contentColors.color
            )

        case .tinted:
            return .init(
                backgroundColor: contentColors.containerColor,
                borderColor: contentColors.containerColor,
                foregroundColor: contentColors.onContainerColor
            )
        }
    }
}
