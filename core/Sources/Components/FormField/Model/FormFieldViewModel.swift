//
//  FormFieldViewModel.swift
//  SparkCore
//
//  Created by alican.aycil on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

final class FormFieldViewModel: ObservableObject {

    // MARK: - Internal properties
    @Published var title: Either<NSAttributedString?, AttributedString?>?
    @Published var titleFont: Either<UIFont, Font>?
    @Published var titleColor: Either<UIColor?, Color?>?
    @Published var titleOpacity: CGFloat?
    @Published var description: Either<NSAttributedString?, AttributedString?>?
    @Published var descriptionFont: Either<UIFont, Font>?
    @Published var descriptionColor: Either<UIColor?, Color?>?
    @Published var descriptionOpacity: CGFloat?
    @Published var spacing: CGFloat

    var theme: Theme {
        didSet {
            self.updateColors()
            self.updateFonts()
            self.updateSpacing()
            self.updateOpacity()
        }
    }

    var intent: FormFieldIntent {
        didSet {
            self.updateColors()
        }
    }

    var isEnabled: Bool {
        didSet {
            self.updateOpacity()
        }
    }

    var colorUseCase: FormFieldColorsUseCase

    // MARK: - Init

    init(
        theme: Theme,
        intent: FormFieldIntent,
        isEnabled: Bool,
        title: Either<NSAttributedString?, AttributedString?>?,
        description: Either<NSAttributedString?, AttributedString?>?,
        colorUseCase: FormFieldColorsUseCase = .init()
    ) {
        self.theme = theme
        self.intent = intent
        self.isEnabled = isEnabled
        self.title = title
        self.description = description
        self.colorUseCase = colorUseCase
        self.spacing = self.theme.layout.spacing.small
    }

    private func updateColors() {
        let colors = colorUseCase.execute(from: self.theme.colors, intent: self.intent)

        if self.title?.leftValue != nil {
            self.titleColor = .left(colors.titleColor.uiColor)
        } else {
            self.titleColor = .right(colors.titleColor.color)
        }

        if self.description?.leftValue != nil {
            self.descriptionColor = .left(colors.descriptionColor.uiColor)
        } else {
            self.descriptionColor = .right(colors.descriptionColor.color)
        }
    }

    private func updateFonts() {
        if self.title?.leftValue != nil {
            self.titleFont = .left(self.theme.typography.subhead.uiFont)
        } else {
            self.titleFont = .right(self.theme.typography.subhead.font)
        }

        if self.description?.leftValue != nil {
            self.descriptionFont = .left(self.theme.typography.caption.uiFont)
        } else {
            self.descriptionFont = .right(self.theme.typography.caption.font)
        }
    }

    private func updateSpacing() {
        self.spacing = self.theme.layout.spacing.small
    }

    private func updateOpacity() {
        self.titleOpacity = isEnabled ? self.theme.dims.none : self.theme.dims.dim3
        self.descriptionOpacity = isEnabled ? self.theme.dims.none : self.theme.dims.dim1
    }
}
