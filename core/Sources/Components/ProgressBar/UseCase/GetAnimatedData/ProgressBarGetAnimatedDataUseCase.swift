//
//  ProgressBarGetAnimatedDataUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol ProgressBarGetAnimatedDataUseCaseable {
    func execute(
        type: ProgressBarIndeterminateAnimationType?,
        trackWidth: CGFloat
    ) -> ProgressBarAnimatedData
}

struct ProgressBarGetAnimatedDataUseCase: ProgressBarGetAnimatedDataUseCaseable {

    // MARK: - Type alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Methods

    func execute(
        type: ProgressBarIndeterminateAnimationType?,
        trackWidth: CGFloat
    ) -> ProgressBarAnimatedData {
        switch type {
        case .easeIn:
            let indicatorMaxWidth = trackWidth * Constants.Animation.maxWidthRatio
            return .init(
                leadingSpaceWidth: (trackWidth - indicatorMaxWidth) / 2,
                indicatorWidth: indicatorMaxWidth
            )

        case .easeOut:
            return .init(
                leadingSpaceWidth: trackWidth,
                indicatorWidth: 0
            )

        case .reset, .none:
            return .init(
                leadingSpaceWidth: 0,
                indicatorWidth: 0
            )
        }
    }
}
