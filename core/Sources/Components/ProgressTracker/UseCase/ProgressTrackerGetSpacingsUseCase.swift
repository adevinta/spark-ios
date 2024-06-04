//
//  ProgressTrackerGetSpacingsUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol ProgressTrackerGetSpacingsUseCaseable {

    func execute(spacing: LayoutSpacing, orientation: ProgressTrackerOrientation) -> ProgressTrackerSpacing
}

/// A use case returning the spacings between the progress tracker indicators
struct ProgressTrackerGetSpacingsUseCase: ProgressTrackerGetSpacingsUseCaseable {

    func execute(spacing: LayoutSpacing, orientation: ProgressTrackerOrientation) -> ProgressTrackerSpacing {

        switch orientation {
        case .horizontal: return ProgressTrackerSpacing(
            trackIndicatorSpacing: spacing.small,
            minLabelSpacing: spacing.medium)
        case .vertical: return ProgressTrackerSpacing(
            trackIndicatorSpacing: spacing.small,
            minLabelSpacing: spacing.medium)
        }

    }

}
