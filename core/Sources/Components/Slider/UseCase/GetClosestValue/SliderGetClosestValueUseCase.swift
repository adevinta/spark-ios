//
//  SliderGetClosestValueUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SliderGetClosestValueUseCasable {
    func execute(from: CGFloat, to: CGFloat, withSteps steps: CGFloat, fromValue value: CGFloat) -> CGFloat
}

final class SliderGetClosestValueUseCase: SliderGetClosestValueUseCasable {
    private let createValuesFromStepsUseCase: SliderCreateValuesFromStepsUseCasable

    init(createValuesFromStepsUseCase: SliderCreateValuesFromStepsUseCasable = SliderCreateValuesFromStepsUseCase()) {
        self.createValuesFromStepsUseCase = createValuesFromStepsUseCase
    }


    func execute(from: CGFloat, to: CGFloat, withSteps steps: CGFloat, fromValue value: CGFloat) -> CGFloat {
        do {
            let values = try self.createValuesFromStepsUseCase.execute(
                from: from,
                to: to,
                steps: steps
            )
            guard let closestValue = values.min(by: {
                return abs($0 - value) <= abs($1 - value)
            }) else { return value }
            return closestValue
        } catch {
            return value
        }
    }
}
