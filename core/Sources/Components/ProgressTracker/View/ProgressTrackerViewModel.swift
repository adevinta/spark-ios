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

    var isEnabled: Bool = true {
        didSet {
            self.updateEnabledIndices()
        }
    }

    var numberOfPages: Int {
        set {
            self.content.numberOfPages = newValue
        }
        get {
            return self.content.numberOfPages
        }
    }

    var currentPageIndex: Int {
        set {
            self.content.currentPageIndex = min(max(0, newValue), self.content.numberOfPages - 1)
        }
        get {
            return self.content.currentPageIndex
        }
    }

    // MARK: Published properties
    @Published var orientation: ProgressTrackerOrientation {
        didSet {
            guard self.orientation != oldValue else { return }
            self.updateSpacings()
        }
    }

    @Published var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent>
    @Published var disabledIndices = Set<Int>()

    @Published var spacings: ProgressTrackerSpacing
    @Published var font: TypographyFontToken

    // MARK: Private properties
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

    func labelColor(forIndex index: Int) -> any ColorToken {
        var color = self.theme.colors.base.onSurface
        if self.disabledIndices.contains(index) {
            color = color.opacity(self.theme.dims.dim1)
        }
        return color
    }

    func labelColor(isDisabled: Bool) -> any ColorToken {
        var color = self.theme.colors.base.onSurface
        if isDisabled {
            color = color.opacity(self.theme.dims.dim1)
        }
        return color
    }

    func setIsEnabled(isEnabled: Bool, forIndex index: Int) {
        if isEnabled {
            self.disabledIndices.remove(index)
        } else {
            self.disabledIndices.insert(index)
        }
    }

    private func updateEnabledIndices() {
        if !self.isEnabled {
            for i in (0..<self.numberOfPages) {
                self.disabledIndices.insert(i)
            }
        } else {
            self.disabledIndices.removeAll()
        }
    }
}
