//
//  TagViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

final class TagViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var colors: TagColorables
    @Published var typography: Typography
    @Published var spacing: LayoutSpacing
    @Published var border: Border

    @Published var iconImage: Image?
    @Published var text: String?

//    private let getHeightUseCase: TagGetHeightUseCaseable

    // MARK: - Init
    init(
        theme: Theme,
        intentColor: TagIntentColor,
        variant: TagVariant,
        iconImage: Image?,
        text: String?,
        getColorsUseCase: TagGetColorsUseCaseable = TagGetColorsUseCase()
//        getHeightUseCase: TagGetHeightUseCaseable = TagGetHeightUseCase()
    ) {
        self.colors = getColorsUseCase.execute(
            from: theme,
            intentColor: intentColor,
            variant: variant
        )
        self.typography = theme.typography
        self.spacing = theme.layout.spacing
        self.border = theme.border

        self.iconImage = iconImage
        self.text = text
    }
}
