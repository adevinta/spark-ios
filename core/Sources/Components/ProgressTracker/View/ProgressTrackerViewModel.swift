//
//  ProgressTrackerViewModel.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

/// A view model for a Progress Tracker.
final class ProgressTrackerViewModel: ObservableObject {

    var theme: Theme {
        didSet {
            self.updateTrackColor()
            self.updateSpacings()
        }
    }

    var intent: ProgressTrackerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.updateTrackColor()
        }
    }

    var isEnabled: Bool = true {
        didSet {
            guard self.isEnabled != oldValue else { return }
            self.updateTrackColor()
        }
    }

    @Published var orientation: ProgressTrackerOrientation {
        didSet {
            guard self.orientation != oldValue else { return }
            self.updateSpacings()
        }
    }

    @Published var trackColor: any ColorToken
    @Published var spacings: ProgressTrackerSpacing

    private var colorUseCase: ProgressTrackerGetTrackColorUseCaseable
    private var spacingUseCase: ProgressTrackerGetSpacingsUseCaseable

    // MARK: - Initialization
    init(theme: Theme,
         intent: ProgressTrackerIntent,
         orientation: ProgressTrackerOrientation,
         colorUseCase: ProgressTrackerGetTrackColorUseCaseable = ProgressTrackerGetTrackColorUseCase(),
         spacingUseCase: ProgressTrackerGetSpacingsUseCaseable = ProgressTrackerGetSpacingsUseCase()
    ) {
        self.orientation = orientation
        self.theme = theme
        self.intent = intent
        self.colorUseCase = colorUseCase
        self.spacingUseCase = spacingUseCase

        self.spacings = spacingUseCase.execute(spacing: theme.layout.spacing, orientation: orientation)
        self.trackColor = colorUseCase.execute(theme: theme, intent: intent, isEnabled: true)
    }

    private func updateTrackColor() {
        self.trackColor = colorUseCase.execute(theme: self.theme, intent: self.intent, isEnabled: self.isEnabled)
    }

    private func updateSpacings() {
        self.spacings = spacingUseCase.execute(spacing: self.theme.layout.spacing, orientation: self.orientation)
    }
}
