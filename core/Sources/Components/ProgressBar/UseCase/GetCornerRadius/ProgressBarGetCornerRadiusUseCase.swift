//
//  ProgressBarGetCornerRadiusUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol ProgressBarGetCornerRadiusUseCaseable {

    // sourcery: border = "Identical"
    func execute(
        shape: ProgressBarShape,
        border: some Border
    ) -> CGFloat
}

struct ProgressBarGetCornerRadiusUseCase: ProgressBarGetCornerRadiusUseCaseable {

    // MARK: - Type alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Methods

    func execute(
        shape: ProgressBarShape,
        border: some Border
    ) -> CGFloat {
        switch shape {
        case .rounded:
            return border.radius.full
        case .square:
            return .zero
        }
    }
}
