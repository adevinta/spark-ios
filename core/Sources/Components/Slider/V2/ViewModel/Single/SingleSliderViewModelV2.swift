//
//  SingleSliderViewModelV2.swift
//  SparkCore
//
//  Created by louis.borlee on 02/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

final class SingleSliderViewModelV2<V>: SliderViewModelV2<V> where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {

    // MARK: - Published values
    @Published private(set) var value: V = 0.0

    func setValue(_ value: V) {
        let newValue = super.getClosestValue(fromValue: value)
        self.value = newValue
    }
}
