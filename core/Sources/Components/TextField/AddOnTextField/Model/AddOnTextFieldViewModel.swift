//
//  AddOnTextFieldViewModel.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 28.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class AddOnTextFieldViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var borderColor: any ColorToken

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

    // MARK: - Private properties

    private let getColorUseCase: AddOnGetColorUseCasable

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: TextFieldIntent,
        getColorUseCase: AddOnGetColorUseCasable = AddOnGetColorUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.getColorUseCase = getColorUseCase

        self.borderColor = getColorUseCase.execute(
            theme: theme,
            intent: intent
        )
    }

    // MARK: - Private methods

    private func updateColor() {
        let newBorderColor = self.getColorUseCase.execute(
            theme: self.theme,
            intent: self.intent
        )
        guard newBorderColor.uiColor != self.borderColor.uiColor else { return }
        self.borderColor = newBorderColor
    }

    // MARK: - Public methods

    public func setTheme(_ theme: Theme) {
        self.theme = theme
    }

    public func setIntent(_ intent: TextFieldIntent) {
        self.intent = intent
    }
}
