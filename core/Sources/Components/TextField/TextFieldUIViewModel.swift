//
//  TextFieldUIViewModel.swift
//  Spark
//
//  Created by Quentin.richard on 21/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

final class TextFieldUIViewModel: ObservableObject {
    // MARK: - Public properties

    @Published var colors: TextFieldColors
    @Published var borderStyle: TextFieldBorder
    @Published var spacing: LayoutSpacing

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

    private let getColorsUseCase: any TextFieldGetColorsUseCaseInterface

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        borderStyle: TextFieldBorder = .round,
        getColorsUseCase: any TextFieldGetColorsUseCaseInterface = TextFieldGetColorsUseCase()
    ) {
        self.colors = Self.getColors(
            for: theme,
            intent: intent,
            useCase: getColorsUseCase
        )

        self.theme = theme
        self.intent = intent
        self.borderStyle = borderStyle
        self.spacing = theme.layout.spacing

        self.getColorsUseCase = getColorsUseCase
    }

    // MARK: - Load

    private func reloadColors() {
        self.colors = Self.getColors(
            for: self.theme,
            intent: intent,
            useCase: getColorsUseCase
        )
    }

    private func reloadTheme() {
        self.spacing = self.theme.layout.spacing
    }

    // MARK: - Public Setter

    func setTheme(_ theme: Theme) {
        self.theme = theme
    }

    func setIntent(_ intent: TextFieldIntent) {
        self.intent = intent
    }


    // MARK: - Getter

    private static func getColors(
        for theme: Theme,
        intent: TextFieldIntent,
        useCase: any TextFieldGetColorsUseCaseInterface
    ) -> TextFieldColors {
        return useCase.execute(
            theme: theme,
            intent: intent
        )
    }
}
