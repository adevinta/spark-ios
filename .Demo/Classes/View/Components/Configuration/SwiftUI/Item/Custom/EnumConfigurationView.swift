//
//  EnumConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct EnumConfigurationView<Value>: View where Value: CaseIterable & Hashable {

    // MARK: - Properties

    let name: String
    let values: [Value]
    @Binding var selectedValue: Value

    // MARK: - View

    var body: some View {
        PickerConfigurationView(
            name: self.name,
            values: self.values,
            selectedValue: self.$selectedValue
        )
    }
}

struct OptionalEnumConfigurationView<Value>: View where Value: CaseIterable & Hashable {

    // MARK: - Properties

    let name: String
    let values: [Value]
    @Binding var selectedValue: Value?

    // MARK: - View

    var body: some View {
        OptionalPickerConfigurationView(
            name: self.name,
            values: self.values,
            selectedValue: self.$selectedValue
        )
    }
}

