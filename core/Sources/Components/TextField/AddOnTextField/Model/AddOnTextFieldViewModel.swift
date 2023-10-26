//
//  AddOnTextFieldViewModel.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 28.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class AddOnTextFieldViewModel: ObservableObject {

    // MARK: - Published properties

    @Published var textFieldColors: TextFieldColors

    // MARK: - Private properties

    private(set) var theme: Theme {
        didSet {
            self.updateColor()
        }
    }

    private(set) var intent: TextFieldIntent {
        didSet {
            self.updateColor()
        }
    }

    private let getColorUseCase: TextFieldGetColorsUseCasable

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: TextFieldIntent,
        getColorUseCase: TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.getColorUseCase = getColorUseCase

        self.textFieldColors = getColorUseCase.execute(
            theme: theme,
            intent: intent
        )
    }

    // MARK: - Private methods

    private func updateColor() {
        let newTextFieldColors = self.getColorUseCase.execute(
            theme: self.theme,
            intent: self.intent
        )
        guard newTextFieldColors != self.textFieldColors else { return }
        self.textFieldColors = newTextFieldColors
    }

    // MARK: - Public methods

    public func setTheme(_ theme: Theme) {
        self.theme = theme
    }

    public func setIntent(_ intent: TextFieldIntent) {
        self.intent = intent
    }
}
