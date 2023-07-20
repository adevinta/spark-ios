//
//  IconViewModel.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class IconViewModel: ObservableObject {

    // MARK: - Properties

    private(set) var theme: Theme
    private(set) var intent: IconIntent
    private let useCase: GetIconColorUseCase

    // MARK: - Published properties

    @Published var color: IconColor
    @Published var size: IconSize

    // MARK: - Initializers

    init(
        theme: Theme,
        intent: IconIntent,
        size: IconSize,
        useCase: GetIconColorUseCase = GetIconColorUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.useCase = useCase
        self.color = useCase.execute(for: intent, colors: theme.colors)
    }

    // MARK: - Setters

    func set(theme: Theme) {
        self.theme = theme
        updateColor()
    }

    func set(intent: IconIntent) {
        self.intent = intent
        updateColor()
    }

    func set(size: IconSize) {
        self.size = size
    }

    // MARK: - Private funcs

    private func updateColor() {
        color = useCase.execute(for: intent, colors: theme.colors)
    }
}
