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

final class FormFieldViewModel<AS: SparkAttributedString>: ObservableObject {

    // MARK: - Internal properties
    @Published private(set) var title: AS?
    @Published var description: AS?
    @Published var titleFont: any TypographyFontToken
    @Published var descriptionFont: any TypographyFontToken
    @Published var titleColor: any ColorToken
    @Published var descriptionColor: any ColorToken
    @Published var spacing: CGFloat

    var theme: Theme {
        didSet {
            self.updateColors()
            self.updateFonts()
            self.updateSpacing()
            self.updateTitle()
        }
    }

    var feedbackState: FormFieldFeedbackState {
        didSet {
            guard feedbackState != oldValue else { return }
            self.updateColors()
        }
    }

    var isTitleRequired: Bool {
        didSet {
            guard isTitleRequired != oldValue else { return }
            self.updateTitle()
        }
    }

    var colors: FormFieldColors

    private var colorUseCase: FormFieldColorsUseCaseable
    private var titleUseCase: FormFieldTitleUseCaseable
    private var userDefinedTitle: AS?

    // MARK: - Init
    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState,
        title: AS?,
        description: AS?,
        isTitleRequired: Bool = false,
        colorUseCase: FormFieldColorsUseCaseable = FormFieldColorsUseCase(),
        titleUseCase: FormFieldTitleUseCaseable = FormFieldTitleUseCase()
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.description = description
        self.isTitleRequired = isTitleRequired
        self.colorUseCase = colorUseCase
        self.titleUseCase = titleUseCase
        self.colors = colorUseCase.execute(from: theme, feedback: feedbackState)
        self.spacing = self.theme.layout.spacing.small
        self.titleFont = self.theme.typography.body2
        self.descriptionFont = self.theme.typography.caption
        self.titleColor = self.colors.title
        self.descriptionColor = self.colors.description
        self.setTitle(title)
    }

    func setTitle(_ title: AS?) {
        self.userDefinedTitle = title
        self.updateTitle()
    }

    private func updateTitle() {
        self.title = self.titleUseCase.execute(title: self.userDefinedTitle, isTitleRequired: self.isTitleRequired, colors: self.colors, typography: self.theme.typography) as? AS
    }

    private func updateColors() {
        self.colors = colorUseCase.execute(from: self.theme, feedback: self.feedbackState)
        self.titleColor = self.colors.title
        self.descriptionColor = self.colors.description
    }

    private func updateFonts() {
        self.titleFont = self.theme.typography.body2
        self.descriptionFont = self.theme.typography.caption
    }

    private func updateSpacing() {
        self.spacing = self.theme.layout.spacing.small
    }
}
