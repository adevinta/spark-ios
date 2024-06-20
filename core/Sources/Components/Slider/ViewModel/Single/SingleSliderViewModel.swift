//
//  SingleSliderViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 02/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

final class SingleSliderViewModel<V>: SliderViewModel<V> where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {

    // MARK: - Published values
    @Published private(set) var value: V = 0.0

    func setValue(_ value: V) {
        let newValue = super.getClosestValue(fromValue: value)
        self.value = newValue
    }

    private func getDefaultIncrementValue() -> V {
        return 10 * (bounds.upperBound - bounds.lowerBound) / 100.0
    }

    func incrementValue() {
        if let step {
            self.setValue(self.value.advanced(by: step))
        } else {
            self.setValue(self.value + self.getDefaultIncrementValue())
        }
    }

    func decrementValue() {
        if let step {
            self.setValue(self.value.advanced(by: -step))
        } else {
            self.setValue(self.value - self.getDefaultIncrementValue())
        }
    }
}
