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

    // MARK: - Private properties

    private let theme: Theme
    private var intentColor: TagIntentColor {
        didSet {
            self.reloadColors()
        }
    }
    private var variant: TagVariant {
        didSet {
            self.reloadColors()
        }
    }

    private let getColorsUseCase: any TagGetColorsUseCaseable

    // MARK: - Initialization

    init(
        theme: Theme,
        intentColor: TagIntentColor = .primary,
        variant: TagVariant = .filled,
        iconImage: Image? = nil,
        text: String? = nil,
        getColorsUseCase: any TagGetColorsUseCaseable = TagGetColorsUseCase()
    ) {
        self.colors = Self.getColors(
            forTheme: theme,
            intentColor: intentColor,
            variant: variant,
            useCase: getColorsUseCase
        )
        self.typography = theme.typography
        self.spacing = theme.layout.spacing
        self.border = theme.border

        self.iconImage = iconImage
        self.text = text

        self.theme = theme
        self.intentColor = intentColor
        self.variant = variant

        self.getColorsUseCase = getColorsUseCase
    }

    // MARK: - Load

    private func reloadColors() {
        self.colors = Self.getColors(
            forTheme: self.theme,
            intentColor: intentColor,
            variant: variant,
            useCase: getColorsUseCase
        )
    }

    // MARK: - Public Setter

    func setIntentColor(_ intentColor: TagIntentColor) {
        self.intentColor = intentColor
    }

    func setVariant(_ variant: TagVariant) {
        self.variant = variant
    }

    func setIconImage(_ iconImage: Image?) {
        self.iconImage = iconImage
    }

    func setText(_ text: String?) {
        self.text = text
    }

    // MARK: - Getter

    private static func getColors(
        forTheme theme: Theme,
        intentColor: TagIntentColor,
        variant: TagVariant,
        useCase: any TagGetColorsUseCaseable
    ) -> TagColorables {
        return useCase.execute(
            forTheme: theme,
            intentColor: intentColor,
            variant: variant
        )
    }
}
