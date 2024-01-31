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
final class ProgressTrackerViewModel<ComponentContent: ProgressTrackerContentIndicating>: ObservableObject {

    var theme: Theme {
        didSet {
            self.updateSpacings()
            self.updateFont()
        }
    }

    var showDefaultPageNumber: Bool {
        get {
            return self.content.showDefaultPageNumber
        }
        set {
            guard self.content.showDefaultPageNumber != newValue else { return }
            self.content.showDefaultPageNumber = newValue
        }
    }

    @Published var orientation: ProgressTrackerOrientation {
        didSet {
            guard self.orientation != oldValue else { return }
            self.updateSpacings()
        }
    }

    @Published var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent>

    @Published var spacings: ProgressTrackerSpacing
    @Published var font: TypographyFontToken

    var numberOfPages: Int {
        set {
            self.content.numberOfPages = newValue
        }
        get {
            return self.content.numberOfPages
        }
    }

    var currentPage: Int {
        set {
            self.content.currentPage = min(max(0, newValue), self.content.numberOfPages - 1)
        }
        get {
            return self.content.currentPage
        }
    }

    private var spacingUseCase: ProgressTrackerGetSpacingsUseCaseable

    // MARK: - Initialization
    init(theme: Theme,
         orientation: ProgressTrackerOrientation,
         content:  ProgressTrackerContent<ProgressTrackerUIIndicatorContent>,
         spacingUseCase: ProgressTrackerGetSpacingsUseCaseable = ProgressTrackerGetSpacingsUseCase()
    ) {
        self.orientation = orientation
        self.theme = theme
        self.content = content
        self.spacingUseCase = spacingUseCase

        self.spacings = spacingUseCase.execute(spacing: theme.layout.spacing, orientation: orientation)

        self.font = theme.typography.body2Highlight
    }

    private func updateSpacings() {
        self.spacings = spacingUseCase.execute(spacing: self.theme.layout.spacing, orientation: self.orientation)
    }

    private func updateFont() {
        self.font = self.theme.typography.body2Highlight
    }
}
