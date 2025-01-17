//
//  SliderConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct SliderConfigurationView<Value>: View where Value: BinaryFloatingPoint, Value.Stride : BinaryFloatingPoint {

    // MARK: - Properties

    let name: String?
    @Binding var selectedValue: Value
    let range: ClosedRange<Value>
    let step: Value.Stride

    // MARK: - View

    var body: some View {
        ItemConfigurationView(name: self.name) {
            Slider(value: self.$selectedValue, in: self.range, step: self.step)
        }
    }
}
