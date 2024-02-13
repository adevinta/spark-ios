//
//  TextFieldViewModel.swift
//  Spark
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

final class TextFieldViewModel: ObservableObject, Updateable {

    // Colors
    @Published private(set) var textColor: any ColorToken
    @Published private(set) var placeholderColor: any ColorToken
    @Published private(set) var borderColor: any ColorToken
    @Published private(set) var statusIconColor: any ColorToken
    @Published private(set) var backgroundColor: any ColorToken

    // BorderLayout
    @Published private(set) var borderRadius: CGFloat
    @Published private(set) var borderWidth: CGFloat

    // Spacings
    @Published private(set) var leftSpacing: CGFloat
    @Published private(set) var contentSpacing: CGFloat
    @Published private(set) var rightSpacing: CGFloat

    @Published private(set) var dim: CGFloat

    @Published private(set) var font: any TypographyFontToken

    @Published private(set) var statusImage: Either<UIImage, Image>?

    var successImage: ImageEither //TODO: Add get/set in views
    var alertImage: ImageEither //TODO: Add get/set in views
    var errorImage: ImageEither //TODO: Add get/set in views

    private let getColorsUseCase: any TextFieldGetColorsUseCasable
    private let getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable
    private let getSpacingsUseCase: any TextFieldGetSpacingsUseCasable

    var theme: Theme {
        didSet {
            self.setColors()
            self.setBorderLayout()
            self.setSpacings()
            self.setDim()
            self.setFont()
        }
    }
    var intent: TextFieldIntent {
        didSet {
            guard oldValue != self.intent else { return }
            self.setColors()
            self.setStatusImage()
        }
    }
    var borderStyle: TextFieldBorderStyle {
        didSet {
            guard oldValue != self.borderStyle else { return }
            self.setBorderLayout()
            self.setSpacings()
        }
    }

    var isFocused: Bool = false {
        didSet {
            guard oldValue != self.isFocused else { return }
            self.setColors()
            self.setBorderLayout()
        }
    }

    var isEnabled: Bool = true {
        didSet {
            guard oldValue != self.isEnabled else { return }
            self.setColors()
            self.setDim()
            self.setStatusImage()
        }
    }

    var isUserInteractionEnabled: Bool = true {
        didSet {
            guard oldValue != self.isUserInteractionEnabled else { return }
            self.setColors()
        }
    }

    init(theme: Theme,
         intent: TextFieldIntent,
         borderStyle: TextFieldBorderStyle,
         successImage: ImageEither,
         alertImage: ImageEither,
         errorImage: ImageEither,
         getColorsUseCase: any TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
         getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
         getSpacingsUseCase: any TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()) {
        self.theme = theme
        self.intent = intent
        self.borderStyle = borderStyle

        self.successImage = successImage
        self.alertImage = alertImage
        self.errorImage = errorImage

        self.getColorsUseCase = getColorsUseCase
        self.getBorderLayoutUseCase = getBorderLayoutUseCase
        self.getSpacingsUseCase = getSpacingsUseCase

        // Colors
        let colors = getColorsUseCase.execute(
            theme: theme,
            intent: intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isUserInteractionEnabled: self.isUserInteractionEnabled
        )
        self.textColor = colors.text
        self.placeholderColor = colors.placeholder
        self.borderColor = colors.border
        self.statusIconColor = colors.statusIcon
        self.backgroundColor = colors.background

        // BorderLayout
        let borderLayout = getBorderLayoutUseCase.execute(
            theme: theme,
            borderStyle:
                borderStyle,
            isFocused: self.isFocused)
        self.borderWidth = borderLayout.width
        self.borderRadius = borderLayout.radius

        // Spacings
        let spacings = getSpacingsUseCase.execute(theme: theme, borderStyle: borderStyle)
        self.leftSpacing = spacings.left
        self.contentSpacing = spacings.content
        self.rightSpacing = spacings.right

        self.dim = theme.dims.none

        self.font = theme.typography.body1

        self.setStatusImage()
    }

    private func setColors() {
        // Colors
        let colors = self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isUserInteractionEnabled: self.isUserInteractionEnabled
        )
        self.updateIfNeeded(keyPath: \.textColor, newValue: colors.text)
        self.updateIfNeeded(keyPath: \.placeholderColor, newValue: colors.placeholder)
        self.updateIfNeeded(keyPath: \.borderColor, newValue: colors.border)
        self.updateIfNeeded(keyPath: \.statusIconColor, newValue: colors.statusIcon)
        self.updateIfNeeded(keyPath: \.backgroundColor, newValue: colors.background)
    }

    private func setBorderLayout() {
        let borderLayout = self.getBorderLayoutUseCase.execute(
            theme: self.theme,
            borderStyle: self.borderStyle,
            isFocused: self.isFocused
        )
        self.updateIfNeeded(keyPath: \.borderWidth, newValue: borderLayout.width)
        self.updateIfNeeded(keyPath: \.borderRadius, newValue: borderLayout.radius)
    }

    private func setSpacings() {
        let spacings = self.getSpacingsUseCase.execute(theme: self.theme, borderStyle: self.borderStyle)
        self.updateIfNeeded(keyPath: \.leftSpacing, newValue: spacings.left)
        self.updateIfNeeded(keyPath: \.contentSpacing, newValue: spacings.content)
        self.updateIfNeeded(keyPath: \.rightSpacing, newValue: spacings.right)
    }

    private func setDim() {
        let dim = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
        self.updateIfNeeded(keyPath: \.dim, newValue: dim)
    }

    private func setFont() {
        self.font = self.theme.typography.body1
    }

    private func setStatusImage() {
        let image: ImageEither?
        if self.isEnabled {
            switch self.intent {
            case .alert:
                image = self.alertImage
            case .error:
                image = self.errorImage
            case .success:
                image = self.successImage
            default:
                image = nil
            }
        } else {
            image = nil
        }
        guard self.statusImage != image else { return }
        self.statusImage = image
    }
}