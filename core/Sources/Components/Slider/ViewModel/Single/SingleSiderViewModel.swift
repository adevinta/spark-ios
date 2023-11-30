//
//  SingleSiderViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 11/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class SingleSliderViewModel: SliderViewModel {

    // MARK: - Published values
    @Published private(set) var value: Float = .zero

    func setAbsoluteValue(_ value: Float) {
        let boundedValue = max(self.minimumValue, min(self.maximumValue, value))
        let newValue = super.getClosestValue(fromValue: boundedValue)
        self.value = newValue
    }
}
