//
//  RadioButtonGroupViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 28.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

/// The RadioButtonGroupViewModel is a view model used by the ``RadioButtonView`` to handle theming logic and state changes.
final class RadioButtonGroupViewModel<Content>: ObservableObject {

    // MARK: - Published Properties
    @Published var sublabelFont: any TypographyFontToken
    @Published var titleFont: any TypographyFontToken
    @Published var titleColor: any ColorToken
    @Published var sublabelColor: any ColorToken
    @Published var spacing: CGFloat
    @Published var labelSpacing: CGFloat
    @Published var isDisabled: Bool
    @Published var content: Content

    // MARK: - Internal Properties
    var theme: any Theme {
        didSet {
            self.sublabelFont =   self.theme.typography.caption
            self.titleFont = self.theme.typography.subhead
            self.titleColor = self.theme.colors.base.onSurface
            self.sublabelColor = useCase.execute(colors: self.theme.colors, intent: self.intent)
            self.spacing = self.theme.layout.spacing.large
            self.labelSpacing = self.theme.layout.spacing.medium
        }
    }

    var intent: RadioButtonIntent {
        didSet {
            guard self.intent != oldValue else { return }

            self.sublabelColor = useCase.execute(colors: self.theme.colors, intent: self.intent)
        }
    }

    // MARK: Private Properties
    private let useCase: any GetRadioButtonGroupColorUseCaseable

    // MARK: Initializers
    convenience init(
        theme: any Theme,
        intent: RadioButtonIntent,
        content: Content
    ) {
        self.init(
            theme: theme,
            intent: intent,
            content: content,
            useCase: GetRadioButtonGroupColorUseCase()
        )
    }

    init(theme: any Theme,
         intent: RadioButtonIntent,
         content: Content,
         useCase: any GetRadioButtonGroupColorUseCaseable) {

        self.theme = theme
        self.intent = intent
        self.useCase = useCase
        self.isDisabled = false
        self.content = content

        self.sublabelFont = self.theme.typography.caption
        self.titleFont = self.theme.typography.subhead
        self.titleColor = self.theme.colors.base.onSurface
        self.sublabelColor = useCase.execute(colors: theme.colors, intent: intent)
        self.spacing = self.theme.layout.spacing.large
        self.labelSpacing = self.theme.layout.spacing.medium
    }
}

