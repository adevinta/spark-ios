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
            if isRequiredTitle {
                self.updateAsterix()
            }
        }
    }
    @Published var titleFont: Either<UIFont, Font>?
    @Published var titleColor: Either<UIColor?, Color?>?
    @Published var description: Either<NSAttributedString?, AttributedString?>?
    @Published var descriptionFont: Either<UIFont, Font>?
    @Published var descriptionColor: Either<UIColor?, Color?>?
    @Published var asteriskText: Either<NSAttributedString?, AttributedString?>?
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

    var isRequiredTitle: Bool {
        didSet {
            guard isRequiredTitle != oldValue else { return }
            self.updateAsterix()
        }
    }

    var colorUseCase: FormFieldColorsUseCaseable

    // MARK: - Init
    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState,
        title: Either<NSAttributedString?, AttributedString?>?,
        description: Either<NSAttributedString?, AttributedString?>?,
        isRequiredTitle: Bool = false,
        colorUseCase: FormFieldColorsUseCaseable = FormFieldColorsUseCase()
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.title = title
        self.description = description
        self.isRequiredTitle = isRequiredTitle
        self.colorUseCase = colorUseCase
        self.spacing = self.theme.layout.spacing.small
    }

    private func updateAsterix() {
        let colors = colorUseCase.execute(from: self.theme, feedback: self.feedbackState)
        let asterix =  NSAttributedString(
            string: " *",
            attributes: [
                NSAttributedString.Key.foregroundColor: colors.asteriskColor.uiColor,
                NSAttributedString.Key.font : self.theme.typography.caption.uiFont
            ]
        )

        if let attributedString = self.title?.optinalLeftValue as? NSAttributedString {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            mutableAttributedString.append(asterix)
            self.asteriskText = self.isRequiredTitle ? .left(NSAttributedString(attributedString: mutableAttributedString)) : nil
        }

        if var attributedString = self.title?.optinalRightValue as? AttributedString {
            attributedString.append(AttributedString(asterix))
            self.asteriskText = self.isRequiredTitle ? .right(attributedString) : nil
        }
    }

    private func updateColors() {
        let colors = colorUseCase.execute(from: self.theme, feedback: self.feedbackState)

        if self.title?.optinalLeftValue != nil {
            self.titleColor = .left(colors.titleColor.uiColor)
        } 

        if self.title?.optinalRightValue != nil {
            self.titleColor = .right(colors.titleColor.color)
        }

        if self.description?.optinalLeftValue != nil {
            self.descriptionColor = .left(colors.descriptionColor.uiColor)
        } 

        if self.description?.optinalRightValue != nil {
            self.descriptionColor = .right(colors.descriptionColor.color)
        }
    }

    private func updateFonts() {

        if self.title?.optinalLeftValue != nil {
            self.titleFont = .left(self.theme.typography.body2.uiFont)
        }

        if self.title?.optinalRightValue != nil {
            self.titleFont = .right(self.theme.typography.body2.font)
        }

        if self.description?.optinalLeftValue != nil {
            self.descriptionFont = .left(self.theme.typography.caption.uiFont)
        } 

        if self.description?.optinalRightValue != nil {
            self.descriptionFont = .right(self.theme.typography.caption.font)
        }
    }

    private func updateSpacing() {
        self.spacing = self.theme.layout.spacing.small
    }
}
