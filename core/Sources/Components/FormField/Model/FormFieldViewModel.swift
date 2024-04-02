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
            self.updateAsterisk()
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
            self.title = self.getTitleWithAsteriskIfNeeded()
        }
    }

    var colors: FormFieldColors

    private var colorUseCase: FormFieldColorsUseCaseable
    private var userDefinedTitle: AS?
    private var asterisk: NSAttributedString = NSAttributedString()

    // MARK: - Init
    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState,
        title: AS?,
        description: AS?,
        isTitleRequired: Bool = false,
        colorUseCase: FormFieldColorsUseCaseable = FormFieldColorsUseCase()
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.userDefinedTitle = title
        self.description = description
        self.isTitleRequired = isTitleRequired
        self.colorUseCase = colorUseCase
        self.colors = colorUseCase.execute(from: theme, feedback: feedbackState)
        self.spacing = self.theme.layout.spacing.small
        self.titleFont = self.theme.typography.body2
        self.descriptionFont = self.theme.typography.caption
        self.titleColor = self.colors.title
        self.descriptionColor = self.colors.description

        self.updateAsterisk()
        self.setTitle(title)
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

    private func updateAsterisk() {
        self.asterisk = NSAttributedString(
            string: " *",
            attributes: [
                NSAttributedString.Key.foregroundColor: self.colors.asterisk.uiColor,
                NSAttributedString.Key.font : self.theme.typography.caption.uiFont
            ]
        )
    }

    func setTitle(_ title: AS?) {
        self.userDefinedTitle = title
        self.title = self.getTitleWithAsteriskIfNeeded()
    }

    private func getTitleWithAsteriskIfNeeded() -> AS? {

        if let attributedString = self.userDefinedTitle as? NSAttributedString {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            if self.isTitleRequired {
                mutableAttributedString.append(self.asterisk)
            }
            return mutableAttributedString as? AS

        } else if var attributedString = self.userDefinedTitle as? AttributedString {
            if self.isTitleRequired {
                attributedString.append(AttributedString(self.asterisk))
            }
            return attributedString as? AS
        }
        return nil
    }
}
