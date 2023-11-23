//
//  SliderCreateStepsUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

enum SliderCreateValuesFromStepsUseCasableError: Error {
    case invalidRange
    case invalidStep
}

// sourcery: AutoMockable
protocol SliderCreateValuesFromStepsUseCasable {
    func execute(from: CGFloat,
                 to: CGFloat,
                 steps: CGFloat) throws -> [CGFloat]
}

final class SliderCreateValuesFromStepsUseCase: SliderCreateValuesFromStepsUseCasable {
    func execute(from: CGFloat, to: CGFloat, steps: CGFloat) throws -> [CGFloat] {
        guard from < to else { throw SliderCreateValuesFromStepsUseCasableError.invalidRange }
        guard steps > .zero,
              steps <= (to - from) else { throw SliderCreateValuesFromStepsUseCasableError.invalidStep }
        
        var values = Array(stride(from: from, through: to, by: steps))
        // Last value should be added when `to` % `step` is > 0
        if values.contains(to) == false {
            values.append(to)
        }
        return values
    }
}
