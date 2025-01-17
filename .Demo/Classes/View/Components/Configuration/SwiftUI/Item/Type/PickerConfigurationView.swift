//
//  PickerConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct PickerConfigurationView<Value>: View where Value: Hashable {

    // MARK: - Properties

    let name: String
    let values: [Value]
    @Binding var selectedValue: Value

    // MARK: - View

    var body: some View {
        ItemConfigurationView(name: self.name) {
            Picker(self.pickerName(from: self.name), selection: self.$selectedValue) {
                ForEach(self.values, id: \.self) { value in
                    self.pickerContent(from: value)
                }
            }
            .pickerStyle()
        }
    }
}

struct OptionalPickerConfigurationView<Value>: View where Value: Hashable {

    // MARK: - Properties

    let name: String
    let values: [Value]
    @Binding var selectedValue: Value?

    // MARK: - View

    var body: some View {
        ItemConfigurationView(name: self.name) {
            Picker(self.pickerName(from: self.name), selection: self.$selectedValue) {
                ForEach(self.values, id: \.self) { value in
                    self.pickerContent(from: value)
                }

                Text("no value").tag(nil as Value?)
            }
            .pickerStyle()
        }
    }
}

// MARK: - Extension

extension PickerConfigurationView: PickerContent {
}

extension OptionalPickerConfigurationView: PickerContent {
}

extension View {

    func pickerStyle() -> some View {
        self.pickerStyle(.menu)
    }
}

// MARK: - Private Protocol

private protocol PickerContent {
}

extension PickerContent {

    func pickerName(from name: String) -> String {
        "\(name.capitalized) selection"
    }

    @ViewBuilder
    func pickerContent<Value>(from value: Value) -> some View where Value: Hashable {
        switch value {
        case let icon as Iconography:
            Image(icon).tag(value)
        default:
            Text("\(value)").tag(value)
        }
    }
}
