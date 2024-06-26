//
//  PopoverViewModel.swift
//  Spark
//
//  Created by louis.borlee on 26/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

struct PopoverViewModel {
    let colors: PopoverColors
    let spaces: PopoverSpaces
    let showArrow: Bool
    let arrowSize: CGFloat

    init(
        theme: Theme,
        intent: PopoverIntent,
        showArrow: Bool,
        getColorsUseCase: PopoverGetColorsUseCasable = PopoverGetColorsUseCase(),
        getSpacesUseCase: PopoverGetSpacesUseCasable = PopoverGetSpacesUseCase()
    ) {
        self.colors = getColorsUseCase.execute(colors: theme.colors, intent: intent)
        self.spaces = getSpacesUseCase.execute(layoutSpacing: theme.layout.spacing)
        self.showArrow = showArrow
        self.arrowSize = theme.layout.spacing.medium
    }
}
