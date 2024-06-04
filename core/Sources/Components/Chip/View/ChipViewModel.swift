//
//  ChipViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

class ChipViewModel<Content>: ObservableObject {

    // MARK: - Properties Injected
    private (set) var theme: Theme
    private (set) var variant: ChipVariant
    private (set) var intent: ChipIntent
    private (set) var alignment: ChipAlignment
    private let useCase: ChipGetColorsUseCasable

    // MARK: - State Properties
    var isEnabled: Bool = true {
        didSet {
            guard isEnabled != oldValue else { return }
            self.updateColors()
        }
    }

    var isPressed: Bool = false {
        didSet {
            guard isPressed != oldValue else { return }
            self.updateColors()
        }
    }

    var isSelected: Bool = false {
        didSet {
            guard isSelected != oldValue else { return }
            self.updateColors()
        }
    }

    // MARK: - Published Properties
    @Published var spacing: CGFloat
    @Published var padding: CGFloat
    @Published var borderRadius: CGFloat
    @Published var font: TypographyFontToken
    @Published var colors: ChipStateColors
    @Published var isIconLeading: Bool
    @Published var content: Content

    // MARK: - Computed variables
    var isBorderDashed: Bool {
        return self.variant.isDashedBorder
    }
    var isBordered: Bool {
        return self.variant.isBordered
    }
    var isBorderPlain: Bool {
        return self.isBordered && !self.isBorderDashed
    }

    // MARK: - Initializers
    convenience init(theme: Theme,
                     variant: ChipVariant,
                     intent: ChipIntent,
                     alignment: ChipAlignment,
                     content: Content
    ) {
        self.init(theme: theme,
                  variant: variant,
                  intent: intent,
                  alignment: alignment,
                  content: content,
                  useCase: ChipGetColorsUseCase())
    }

    init(theme: Theme,
         variant: ChipVariant,
         intent: ChipIntent,
         alignment: ChipAlignment,
         content: Content,
         useCase: ChipGetColorsUseCasable) {
        self.theme = theme
        self.variant = variant
        self.intent = intent
        self.useCase = useCase
        self.alignment = alignment
        self.content = content
        self.colors = useCase.execute(theme: theme, variant: variant, intent: intent, state: .default)
        self.spacing = self.theme.layout.spacing.small
        self.padding = self.theme.layout.spacing.medium
        self.borderRadius = self.theme.border.radius.medium
        self.font = self.theme.bodyFont
        self.isIconLeading = alignment.isIconLeading
    }

    func set(theme: Theme) {
        self.theme = theme
        self.themeDidUpdate()
    }

    func set(variant: ChipVariant) {
        guard self.variant != variant else { return }

        self.variant = variant
        self.variantDidUpdate()
    }

    func set(intent: ChipIntent) {
        guard self.intent != intent else { return }

        self.intent = intent
        self.intentColorsDidUpdate()
    }

    func set(alignment: ChipAlignment) {
        guard self.alignment != alignment else { return }

        self.alignment = alignment
        self.isIconLeading = alignment.isIconLeading
    }

    // MARK: - Private functions
    private func updateColors() {
        let state = ChipState(isEnabled: self.isEnabled, isPressed: self.isPressed, isSelected: self.isSelected)
        self.colors = self.useCase.execute(theme: self.theme, variant: self.variant, intent: self.intent, state: state)
    }

    private func themeDidUpdate() {
        self.updateColors()

        self.spacing = self.theme.layout.spacing.small
        self.padding = self.theme.layout.spacing.medium
        self.borderRadius = self.theme.border.radius.medium
        self.font = self.theme.bodyFont
    }

    private func variantDidUpdate() {
        self.updateColors()
    }

    private func intentColorsDidUpdate() {
        self.updateColors()
    }
}

private extension Theme {
    var bodyFont: TypographyFontToken {
        return self.typography.body1
    }
}

private extension ChipVariant {
    var isBordered: Bool {
        return self == .dashed || self == .outlined
    }

    var isDashedBorder: Bool {
        return self == .dashed
    }
}

private extension ChipAlignment {
    var isIconLeading: Bool {
        return self == .leadingIcon
    }
}
