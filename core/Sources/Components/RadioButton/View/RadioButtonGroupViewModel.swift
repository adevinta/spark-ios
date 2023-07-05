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
final class RadioButtonGroupViewModel: ObservableObject {

    @Published var sublabelFont: any TypographyFontToken
    @Published var titleFont: any TypographyFontToken
    @Published var titleColor: any ColorToken
    @Published var sublabelColor: any ColorToken
    @Published var spacing: CGFloat
    @Published var labelSpacing: CGFloat

    private let useCase: any GetRadioButtonGroupColorUseCaseable

    var theme: any Theme {
        didSet {
            self.sublabelFont =   self.theme.typography.caption
            self.titleFont = self.theme.typography.subhead
            self.titleColor = self.theme.colors.base.onSurface
            self.sublabelColor = useCase.execute(colors: self.theme.colors, state: self.state)
            self.spacing = self.theme.layout.spacing.large
            self.labelSpacing = self.theme.layout.spacing.medium
        }
    }
    var state: RadioButtonGroupState {
        didSet {
            guard self.state != oldValue else { return }

            self.sublabelColor = useCase.execute(colors: self.theme.colors, state: self.state)
        }
    }

    convenience init(theme: any Theme, state: RadioButtonGroupState) {
        self.init(theme: theme, state: state, useCase: GetRadioButtonGroupColorUseCase())
    }

    init(theme: any Theme,
             state: RadioButtonGroupState,
             useCase: any GetRadioButtonGroupColorUseCaseable) {
        self.theme = theme
        self.state = state
        self.useCase = useCase

        self.sublabelFont =   self.theme.typography.caption
        self.titleFont = self.theme.typography.subhead
        self.titleColor = self.theme.colors.base.onSurface
        self.sublabelColor = useCase.execute(colors: theme.colors, state: state)
        self.spacing = self.theme.layout.spacing.large
        self.labelSpacing = self.theme.layout.spacing.medium
    }
}

