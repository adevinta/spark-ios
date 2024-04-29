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

class TextFieldViewModel: ObservableObject, Updateable {

    // Colors
    @Published private(set) var textColor: any ColorToken
    @Published private(set) var placeholderColor: any ColorToken
    @Published var borderColor: any ColorToken
    @Published var backgroundColor: any ColorToken

    // BorderLayout
    @Published private(set) var borderRadius: CGFloat
    @Published private(set) var borderWidth: CGFloat

    // Spacings
    @Published private(set) var leftSpacing: CGFloat
    @Published private(set) var contentSpacing: CGFloat
    @Published private(set) var rightSpacing: CGFloat

    @Published var dim: CGFloat

    @Published private(set) var font: any TypographyFontToken

    let getColorsUseCase: any TextFieldGetColorsUseCasable
    let getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable
    let getSpacingsUseCase: any TextFieldGetSpacingsUseCasable

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
         getColorsUseCase: any TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
         getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
         getSpacingsUseCase: any TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()) {
        self.theme = theme
        self.intent = intent
        self.borderStyle = borderStyle

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
    }

    func setColors() {
        // Colors
        let colors = self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isUserInteractionEnabled: self.isUserInteractionEnabled
        )
        self.textColor = colors.text
        self.placeholderColor = colors.placeholder
        self.borderColor = colors.border
        self.backgroundColor = colors.background
    }

    func setBorderLayout() {
        let borderLayout = self.getBorderLayoutUseCase.execute(
            theme: self.theme,
            borderStyle: self.borderStyle, //.none
            isFocused: self.isFocused
        )
        self.borderWidth = borderLayout.width
        self.borderRadius = borderLayout.radius
    }

    func setSpacings() {
        let spacings = self.getSpacingsUseCase.execute(theme: self.theme, borderStyle: self.borderStyle)
        self.leftSpacing = spacings.left
        self.contentSpacing = spacings.content
        self.rightSpacing = spacings.right
    }

    func setDim() {
        self.dim = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
    }

    private func setFont() {
        self.font = self.theme.typography.body1
    }

    func enabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }

    func focused(_ isFocused: Bool) -> Self {
        self.isFocused = isFocused
        return self
    }
}
