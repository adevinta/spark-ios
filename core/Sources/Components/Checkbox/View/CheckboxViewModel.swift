//
//  CheckboxViewModel.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 05.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class CheckboxViewModel: ObservableObject {
    public var text: String

    @Published public var theming: CheckboxTheming
    @Published public var state: SelectButtonState

    @Published public var colors: CheckboxColorables
    private let colorsUseCase: CheckboxColorsUseCaseable

    init(
        text: String,
        theming: CheckboxTheming,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled
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
