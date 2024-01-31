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

    var isEnabled: Bool {
        didSet {
            guard self.isEnabled != oldValue else { return }
            self.updateLineColor()
        }
    }

    private var useCase: ProgressTrackerGetTrackColorUseCaseable
    @Published var lineColor: any ColorToken

    init(theme: Theme,
         intent: ProgressTrackerIntent,
         isEnabled: Bool = true,
         useCase: ProgressTrackerGetTrackColorUseCaseable = ProgressTrackerGetTrackColorUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.useCase = useCase
        self.isEnabled = isEnabled
        self.lineColor = useCase.execute(theme: theme, intent: intent, isEnabled: isEnabled)
    }

    private func updateLineColor() {
        let newLineColor = useCase.execute(theme: theme, intent: intent, isEnabled: isEnabled)
        if !newLineColor.equals(self.lineColor) {
            self.lineColor = newLineColor
        }
    }
}
