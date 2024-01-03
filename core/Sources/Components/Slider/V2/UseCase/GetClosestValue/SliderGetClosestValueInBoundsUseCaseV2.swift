//
//  SliderGetClosestValueUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol SliderGetClosestValueUseCasableV2 {
    func execute<V>(value: V, in values: [V]) -> V where V: BinaryFloatingPoint
}

final class SliderGetClosestValueUseCaseV2: SliderGetClosestValueUseCasableV2 {
    func execute<V>(value: V, in values: [V]) -> V where V : BinaryFloatingPoint {
        guard let closestValue = values.min(by: {
            return abs($0 - value) <= abs($1 - value)
        }) else { return value }
        return closestValue
    }
}
