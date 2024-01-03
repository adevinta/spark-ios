//
//  SliderGetStepValuesInBoundsUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol SliderGetStepValuesInBoundsUseCasable {
    func execute<V>(bounds: ClosedRange<V>, step: V.Stride) -> [V] where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint
}

final class SliderGetStepValuesInBoundsUseCase: SliderGetStepValuesInBoundsUseCasable {
    func execute<V>(bounds: ClosedRange<V>, step: V.Stride) -> [V] where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
        return stride(from: bounds.lowerBound, through: bounds.upperBound, by: step).sorted()
    }
}
