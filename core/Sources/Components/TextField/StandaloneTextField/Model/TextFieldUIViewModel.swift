//
//  TextFieldUIViewModel.swift
//  Spark
//
//  Created by Quentin.richard on 21/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

final class TextFieldUIViewModel: ObservableObject {
    // MARK: - Public properties
    
    @Published var colors: TextFieldColors
    @Published var borders: TextFieldBorders
    @Published var spacings: TextFieldSpacings
    @Published var statusIcon: UIImage?

    // MARK: - Private properties
    
    private(set) var theme: Theme {
        didSet {
            self.reloadTheme()
        }
    }
    private(set) var intent: TextFieldIntent {
        didSet {
            self.reloadColors()
        }
    }
    private(set) var borderStyle: TextFieldBorderStyle {
        didSet {
            self.reloadSpacings()
            self.reloadBorders()
        }
    }

    private let errorIcon: UIImage
    private let alertIcon: UIImage
    private let successIcon: UIImage

    private let getColorsUseCase: any TextFieldGetColorsUseCasable
    private let getBordersUseCase: any TextFieldGetBordersUseCasable
    private let getSpacingsUseCase: any TextFieldGetSpacingsUseCasable

    // MARK: - Initialization

    init(
        theme: Theme,
        borderStyle: TextFieldBorderStyle,
        errorIcon: UIImage,
        alertIcon: UIImage,
        successIcon: UIImage,
        intent: TextFieldIntent = .neutral,
        getColorsUseCase: any TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
        getBordersUseCase: any TextFieldGetBordersUseCasable = TextFieldGetBordersUseCase(),
        getSpacingsUseCase: any TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()
    ) {
        // Properties
        self.theme = theme
        self.intent = intent
        self.borderStyle = borderStyle
        self.errorIcon = errorIcon
        self.alertIcon = alertIcon
        self.successIcon = successIcon

        // Use cases
        self.getColorsUseCase = getColorsUseCase
        self.getBordersUseCase = getBordersUseCase
        self.getSpacingsUseCase = getSpacingsUseCase

        // Published vars
        self.colors = getColorsUseCase.execute(theme: theme, intent: intent)
        self.borders = getBordersUseCase.execute(theme: theme, borderStyle: borderStyle)
        self.spacings = getSpacingsUseCase.execute(theme: theme, borderStyle: borderStyle)
    }

    // MARK: - Update
    private func reloadColors() {
        let newColors = self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent
        )
        guard newColors != self.colors else { return }
        self.colors = newColors
    }

    private func reloadSpacings() {
        let newSpacings = self.getSpacingsUseCase.execute(
            theme: self.theme,
            borderStyle: self.borderStyle
        )
        guard newSpacings != self.spacings else { return }
        self.spacings = newSpacings
    }

    private func reloadBorders() {
        let newBorders = self.getBordersUseCase.execute(
            theme: self.theme,
            borderStyle: self.borderStyle
        )
        guard newBorders != self.borders else { return }
        self.borders = newBorders
    }

    private func reloadTheme() {
        self.reloadColors()
        self.reloadSpacings()
        self.reloadBorders()
    }

    private func updateStatusIcon(for intent: TextFieldIntent) {
        switch intent {
        case .error:
            self.statusIcon = errorIcon
        case .alert:
            self.statusIcon = alertIcon
        case .neutral:
            self.statusIcon = nil
        case .success:
            self.statusIcon = successIcon
        }
    }

    // MARK: - Public Setter

    func setTheme(_ theme: Theme) {
        self.theme = theme
    }

    func setIntent(_ intent: TextFieldIntent) {
        self.intent = intent
        self.updateStatusIcon(for: intent)
    }

    func setBorderStyle(_ borderStyle: TextFieldBorderStyle) {
        self.borderStyle = borderStyle
    }
}
