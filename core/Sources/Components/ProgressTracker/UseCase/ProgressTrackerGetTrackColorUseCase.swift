//
//  ProgressTrackerGetTrackColorUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ProgressTrackerGetTrackColorUseCaseable {
    func execute(theme: Theme,
                 intent: ProgressTrackerIntent,
                 isEnabled: Bool) -> any ColorToken
}

/// A use cate returning the color of the `track` between the progress tracker indicators.
struct ProgressTrackerGetTrackColorUseCase: ProgressTrackerGetTrackColorUseCaseable {

    func execute(theme: Theme,
                 intent: ProgressTrackerIntent,
                 isEnabled: Bool) -> any ColorToken {

        let colorToken: any ColorToken = {
            switch intent {
            case .basic: return theme.colors.basic.basic
            case .accent: return theme.colors.accent.accent
            case .alert: return theme.colors.feedback.alert
            case .danger: return theme.colors.feedback.error
            case .info: return theme.colors.feedback.info
            case .main: return theme.colors.main.main
            case .neutral: return theme.colors.feedback.neutral
            case .success: return theme.colors.feedback.success
            case .support: return theme.colors.support.support
            }
        }()

        return isEnabled ? colorToken : colorToken.opacity(theme.dims.dim3)
    }
}
