//
//  ProgressTrackerTrackViewModel.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

final class ProgressTrackerTrackViewModel: ObservableObject {
    
    var theme: Theme {
        didSet {
            self.updateLineColor()
        }
    }

    var intent: ProgressTrackerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.updateLineColor()
        }
    }

    var state: ProgressTrackerState {
        didSet {
            guard self.state != oldValue else { return }
            self.updateLineColor()
        }
    }

    private let useCase: ProgressTrackerGetColorsUseCaseable
    @Published var lineColor: any ColorToken

    init(theme: Theme,
         intent: ProgressTrackerIntent,
         state: ProgressTrackerState = .normal,
         useCase: ProgressTrackerGetColorsUseCaseable = ProgressTrackerGetColorsUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.state = state
        self.useCase = useCase
        self.lineColor = useCase.execute(theme: theme, intent: intent, variant: .outlined, state: state).outline
    }

    private func updateLineColor() {
        let newLineColor = self.useCase.execute(
            theme: self.theme,
            intent: self.intent,
            variant: .outlined,
            state: self.state).outline
        if !newLineColor.equals(self.lineColor) {
            self.lineColor = newLineColor
        }
    }
}
