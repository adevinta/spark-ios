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
    @Published var title: Either<NSAttributedString?, AttributedString?>? {
        didSet {
            if isTitleRequired {
                self.updateAsterix()
            }
        }
    }
    @Published var description: Either<NSAttributedString?, AttributedString?>?
    @Published var asteriskText: Either<NSAttributedString?, AttributedString?>?
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
            self.updateAsterix()
        }
    }

    private var colorUseCase: FormFieldColorsUseCaseable

    private var colors: FormFieldColors

    // MARK: - Init
    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState,
        title: Either<NSAttributedString?, AttributedString?>?,
        description: Either<NSAttributedString?, AttributedString?>?,
        isTitleRequired: Bool = false,
        colorUseCase: FormFieldColorsUseCaseable = FormFieldColorsUseCase()
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.title = title
        self.description = description
        self.isTitleRequired = isTitleRequired
        self.colorUseCase = colorUseCase
        self.colors = colorUseCase.execute(from: theme, feedback: feedbackState)
        self.spacing = self.theme.layout.spacing.small
        self.titleFont = self.theme.typography.body2
        self.descriptionFont = self.theme.typography.caption
        self.titleColor = self.colors.titleColor
        self.descriptionColor = self.colors.descriptionColor
    }

    private func updateAsterix() {
        let asterisk =  NSAttributedString(
            string: " *",
            attributes: [
                NSAttributedString.Key.foregroundColor: self.colors.asteriskColor.uiColor,
                NSAttributedString.Key.font : self.theme.typography.caption.uiFont
            ]
        )

        switch self.title {
        case let .left(text):
            if let text = text {
                let mutableAttributedString = NSMutableAttributedString(attributedString: text)
                mutableAttributedString.append(asterisk)
                self.asteriskText = self.isTitleRequired ? .left(NSAttributedString(attributedString: mutableAttributedString)) : nil
            }

        case let .right(text):
            if var text = text {
                text.append(AttributedString(asterisk))
                self.asteriskText = self.isTitleRequired ? .right(text) : nil
            }
        case .none:
            self.asteriskText = nil
        }
    }

    private func updateColors() {
        self.colors = colorUseCase.execute(from: self.theme, feedback: self.feedbackState)
        self.titleColor = self.colors.titleColor
        self.descriptionColor = self.colors.descriptionColor
    }

    private func updateFonts() {
        self.titleFont = self.theme.typography.body2
        self.descriptionFont = self.theme.typography.caption
    }

    private func updateSpacing() {
        self.spacing = self.theme.layout.spacing.small
    }
}
