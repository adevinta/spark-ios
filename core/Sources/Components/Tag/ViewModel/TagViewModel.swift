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

    @Published var colors: TagColors
    @Published var typography: Typography
    @Published var spacing: LayoutSpacing
    @Published var border: Border

    @Published var iconImage: Image?
    @Published var text: String?

    // MARK: - Private properties

    private let theme: Theme
    private var intent: TagIntent {
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
        intent: TagIntent = .primary,
        variant: TagVariant = .filled,
        iconImage: Image? = nil,
        text: String? = nil,
        getColorsUseCase: any TagGetColorsUseCaseable = TagGetColorsUseCase()
    ) {
        self.colors = Self.getColors(
            for: theme,
            intent: intent,
            variant: variant,
            useCase: getColorsUseCase
        )
        self.typography = theme.typography
        self.spacing = theme.layout.spacing
        self.border = theme.border

        self.iconImage = iconImage
        self.text = text

        self.theme = theme
        self.intent = intent
        self.variant = variant

        self.getColorsUseCase = getColorsUseCase
    }

    // MARK: - Load

    private func reloadColors() {
        self.colors = Self.getColors(
            for: self.theme,
            intent: intent,
            variant: variant,
            useCase: getColorsUseCase
        )
    }

    // MARK: - Public Setter

    func setIntent(_ intent: TagIntent) {
        self.intent = intent
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
        for theme: Theme,
        intent: TagIntent,
        variant: TagVariant,
        useCase: any TagGetColorsUseCaseable
    ) -> TagColors {
        return useCase.execute(
            theme: theme,
            intent: intent,
            variant: variant
        )
    }
}
