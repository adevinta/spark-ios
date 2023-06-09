//
//  ButtonViewModel.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 09.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class ButtonViewModel: ObservableObject {
    // MARK: - Internal properties

    var text: String
    var icon: ButtonIcon

    var shape: ButtonShape = .rounded
    var size: ButtonSize = .medium

    @Published var theme: Theme {
        didSet {
            self.updateColors()
        }
    }

    var state: ButtonState
    var intentColor: ButtonIntentColor {
        didSet {
            self.updateColors()
        }
    }

    var variant: ButtonVariant {
        didSet {
            self.updateColors()
        }
    }

    @Published var colors: ButtonColorables
    var colorsUseCase: ButtonGetColorsUseCaseable {
        didSet {
            self.updateColors()
        }
    }

    // MARK: - Init

    init(
        text: String,
        icon: ButtonIcon,
        theme: Theme,
        colorsUseCase: ButtonGetColorsUseCaseable = ButtonGetColorsUseCase(),
        state: ButtonState = .enabled,
        intentColor: ButtonIntentColor,
        variant: ButtonVariant
    ) {
        self.text = text
        self.icon = icon
        self.theme = theme
        self.state = state
        self.intentColor = intentColor
        self.variant = variant

        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(from: theme, intentColor: intentColor, variant: variant)
    }

    // MARK: - Methods

    private func updateColors() {
        self.colors = self.colorsUseCase.execute(from: self.theme, intentColor: self.intentColor, variant: self.variant)
    }

    // MARK: - Computed properties

    var interactionEnabled: Bool {
        switch self.state {
        case .disabled:
            return false
        default:
            return true
        }
    }

    var opacity: CGFloat {
        switch self.state {
        case .disabled:
            return Constants.opacityDisabled
        default:
            return Constants.opacityEnabled
        }
    }

    var hasIcon: Bool {
        switch self.icon {
        case .none:
            return false
        default:
            return true
        }
    }

    var hasText: Bool {
        switch self.icon {
        case .iconOnly:
            return false
        default:
            return true
        }
    }
}

// MARK: -  Constants

private enum Constants {
    static let opacityDisabled: CGFloat = 0.3
    static let opacityEnabled: CGFloat = 1.0
}
