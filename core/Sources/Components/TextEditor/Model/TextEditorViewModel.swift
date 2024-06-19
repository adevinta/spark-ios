//
//  TextEditorViewModel.swift
//  SparkCore
//
//  Created by alican.aycil on 23.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class TextEditorViewModel: ObservableObject {

    // Colors
    @Published private(set) var textColor: any ColorToken
    @Published private(set) var placeholderColor: any ColorToken
    @Published private(set) var borderColor: any ColorToken
    @Published private(set) var backgroundColor: any ColorToken

    // BorderLayout
    @Published private(set) var borderRadius: CGFloat
    @Published private(set) var borderWidth: CGFloat

    // Spacings
    @Published private(set) var horizontalSpacing: CGFloat

    // Font
    @Published private(set) var font: any TypographyFontToken

    // Use Cases
    let getColorsUseCase: any TextEditorColorsUseCasable
    let getBorderUseCase: any TextEditorBordersUseCasable

    var theme: Theme {
        didSet {
            self.setColors()
            self.setBorderLayout()
            self.setSpacings()
            self.setFont()
        }
    }
    var intent: TextEditorIntent {
        didSet {
            guard oldValue != self.intent else { return }
            self.setColors()
            self.setBorderLayout()
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
            self.setBorderLayout()
        }
    }

    var isReadOnly: Bool = false {
        didSet {
            guard oldValue != self.isReadOnly else { return }
            self.setColors()
            self.setBorderLayout()
        }
    }

    init(theme: Theme,
         intent: TextEditorIntent,
         getColorsUseCase: any TextEditorColorsUseCasable = TextEditorColorsUseCase(),
         getBorderUseCase: any TextEditorBordersUseCasable = TextEditorBordersUseCase()) {
        
        self.theme = theme
        self.intent = intent

        // Use Cases
        self.getColorsUseCase = getColorsUseCase
        self.getBorderUseCase = getBorderUseCase

        // Colors
        let colors = getColorsUseCase.execute(
            theme: theme,
            intent: intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isReadonly: self.isReadOnly
        )
        self.textColor = colors.text
        self.placeholderColor = colors.placeholder
        self.borderColor = colors.border
        self.backgroundColor = colors.background

        // BorderLayout
        let borderLayout = getBorderUseCase.execute(
            theme: theme,
            intent: intent,
            isFocused: isFocused)
        self.borderWidth = borderLayout.width
        self.borderRadius = borderLayout.radius

        // Spacing
        self.horizontalSpacing = theme.layout.spacing.large

        // Font
        self.font = theme.typography.body1
    }

    private func setColors() {
        // Colors
        let colors = self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isReadonly: self.isReadOnly
        )
        self.textColor = colors.text
        self.placeholderColor = colors.placeholder
        self.borderColor = colors.border
        self.backgroundColor = colors.background
    }

    private func setBorderLayout() {
        let borderLayout = self.getBorderUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            isFocused: self.isFocused
        )
        self.borderWidth = borderLayout.width
        self.borderRadius = borderLayout.radius
    }

    private func setSpacings() {
        self.horizontalSpacing = theme.layout.spacing.large
    }

    private func setFont() {
        self.font = self.theme.typography.body1
    }
}
