//
//  SparkCheckboxViewModel.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 05.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class SparkCheckboxViewModel: ObservableObject {
    public var text: String

    @Published public var theming: SparkCheckboxTheming
    @Published public var state: SparkSelectButtonState

    @Published private(set) var colors: SparkCheckboxColorables
    private let colorsUseCase: SparkCheckboxColorsUseCaseable

    init(
        text: String,
        theming: SparkCheckboxTheming,
        colorsUseCase: SparkCheckboxColorsUseCaseable = SparkCheckboxColorsUseCase(),
        state: SparkSelectButtonState = .enabled
    ) {
        self.text = text
        self.theming = theming
        self.state = state

        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(from: theming, state: state)
    }

    var interactionEnabled: Bool {
        switch state {
        case .disabled:
            return false
        default:
            return true
        }
    }

    var opacity: CGFloat {
        switch state {
        case .disabled:
            return theming.theme.dims.dim3
        default:
            return 1.0
        }
    }

    var supplementaryMessage: String? {
        switch state {
        case .error(let message), .success(let message), .warning(let message):
            return message
        default:
            return nil
        }
    }
}
