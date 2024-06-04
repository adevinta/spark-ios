//
//  ProgressTrackerIndicatorViewModel.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 22.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI
import SparkTheming

/// A view model for a single Progress Tracker Indicator 
final class ProgressTrackerIndicatorViewModel<ComponentContent: ProgressTrackerContentIndicating>: ObservableObject {

    var theme: Theme {
        didSet {
            self.updateColors()
            self.font = theme.typography.body2Highlight
        }
    }

    var intent: ProgressTrackerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.updateColors()
        }
    }

    var variant: ProgressTrackerVariant {
        didSet {
            guard self.variant != oldValue else { return }
            self.updateColors()
        }
    }

    var state: ProgressTrackerState {
        didSet {
            guard self.state != oldValue else { return }
            self.updateColors()
            self.updateOpacity()
        }
    }

    // MARK: - Private properties
    private let colorsUseCase: ProgressTrackerGetColorsUseCaseable

    // MARK: - Published properties
    @Published var size: ProgressTrackerSize
    @Published var content: ComponentContent
    @Published var colors: ProgressTrackerColors
    @Published var font: TypographyFontToken
    @Published var opacity: CGFloat = 1.0

    // MARK: Initialization
    init(theme: Theme,
         intent: ProgressTrackerIntent,
         variant: ProgressTrackerVariant,
         size: ProgressTrackerSize,
         content: ComponentContent,
         state: ProgressTrackerState = .normal,
         colorsUseCase: ProgressTrackerGetColorsUseCaseable = ProgressTrackerGetColorsUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.size = size
        self.content = content
        self.colorsUseCase = colorsUseCase
        self.state = state

        self.colors = colorsUseCase.execute(colors: theme.colors, intent: intent, variant: variant, state: state)

        self.font = theme.typography.body2Highlight
        self.updateOpacity()
    }

    private func updateColors() {
        self.colors = self.colorsUseCase.execute(colors: theme.colors, intent: intent, variant: variant, state: self.state)
    }

    private func updateOpacity() {
        self.opacity = self.state.isEnabled ? 1.0 : self.theme.dims.dim3
    }

    func set(enabled: Bool) {
        self.state.isEnabled = enabled
    }

    func set(highlighted: Bool) {
        self.state.isPressed = highlighted
    }

    func set(selected: Bool) {
        self.state.isSelected = selected
    }
}
