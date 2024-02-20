//
//  ProgressTrackerTrackView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 15.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct ProgressTrackerTrackView: View {
    @ObservedObject private var viewModel: ProgressTrackerTrackViewModel
    private let orientation: ProgressTrackerOrientation

    @ScaledMetric private var scaleFactor = 1.0

    private var trackSize: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.trackSize
    }

    init(theme: Theme,
         intent: ProgressTrackerIntent,
         orientation: ProgressTrackerOrientation) {
        self.orientation = orientation
        self.viewModel = ProgressTrackerTrackViewModel(theme: theme, intent: intent)
    }

    var body: some View {
        if self.orientation == .horizontal {
            self.line()
                .frame(height: self.trackSize)
                .frame(minWidth: self.trackSize)
        } else {
            self.line()
                .frame(width: self.trackSize)
                .frame(minHeight: self.trackSize)
        }
    }

    @ViewBuilder
    private func line() -> some View {
        Rectangle()
            .fill(self.viewModel.lineColor.color)
            .opacity(self.viewModel.opacity)
            .isEnabledChanged { isEnabled in
                self.viewModel.isEnabled = isEnabled
            }
    }
}
