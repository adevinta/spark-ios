//
//  SliderComponentView.swift
//  SparkDemo
//
//  Created by louis.borlee on 04/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

// swiftlint:disable no_debugging_method
struct SliderComponentView: View {

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: SliderIntent = .basic
    @State private var shape: SliderShape = .square

    @State private var selectionState: CheckboxSelectionState = .selected

    @State private var isEditing: Bool = false

    @State private var value: Float
    @State private var valueString: String
    @FocusState private var isValueFieldFocused: Bool

    @State private var step: Float.Stride
    @State private var stepString: String
    @FocusState private var isStepFieldFocused: Bool

    @State private var bounds: ClosedRange<Float>
    @State private var lowerBoundString: String
    @FocusState private var isLowerBoundFocused: Bool
    @State private var upperBoundString: String
    @FocusState private var isUpperBoundFocused: Bool

    init(value: Float = 0,
         step: Float.Stride = 0,
         bounds: ClosedRange<Float> = 0...1) {
        _value = State(initialValue: value)
        _valueString = State(initialValue: "\(value)")

        _step = State(initialValue: step)
        _stepString = State(initialValue: "\(step)")

        _bounds = State(initialValue: bounds)
        _lowerBoundString = State(initialValue: "\(bounds.lowerBound)")
        _upperBoundString = State(initialValue: "\(bounds.upperBound)")
    }

    var body: some View {
        Component(
            name: "Slider",
            configuration: {
                ThemeSelector(theme: self.$theme)
                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: SliderIntent.allCases,
                    value: self.$intent
                )
                EnumSelector(
                    title: "Shape",
                    dialogTitle: "Select an shape",
                    values: SliderShape.allCases,
                    value: self.$shape
                )
                Checkbox(title: "IsEnabled", selectionState: $selectionState)
                Text("IsEditing: \(self.isEditing ? "true" : "false")")
                HStack {
                    Text("Value:")
                    TextField("", text: $valueString, onEditingChanged: { _ in
                        guard let newValue = Float(valueString) else { return }
                        self.value = newValue
                    })
                    .focused($isValueFieldFocused)
                }
                HStack {
                    Text("Step:")
                    TextField("", text: $stepString, onEditingChanged: { _ in
                        guard let newStep = Float(stepString) else { return }
                        self.step = newStep
                    })
                    .focused($isStepFieldFocused)
                }
                HStack {
                    Text("Bounds:")
                    TextField("", text: $lowerBoundString, onEditingChanged: { _ in
                        guard let newLowerBound = Float(lowerBoundString) else { return }
                        self.bounds = newLowerBound...self.bounds.upperBound
                    })
                    .focused($isLowerBoundFocused)
                    TextField("", text: $upperBoundString, onEditingChanged: { _ in
                        guard let newUpperBound = Float(upperBoundString) else { return }
                        self.bounds = self.bounds.lowerBound...newUpperBound
                    })
                    .focused($isUpperBoundFocused)
                }
            },
            integration: {
                VStack {
                    SparkCore.Slider(
                        theme: self.theme,
                        shape: self.shape,
                        intent: self.intent,
                        value: $value,
                        in: self.bounds,
                        step: self.step,
                        onEditingChanged: { isEditing in
                            self.isEditing = isEditing
                        })
                    .disabled(self.selectionState == .unselected)
                }
            }
        )
        .textFieldStyle(.roundedBorder)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isValueFieldFocused = false
                    isStepFieldFocused = false
                    isLowerBoundFocused = false
                    isUpperBoundFocused = false
                }
            }
        }
        .onChange(of: value, perform: { newValue in
            self.valueString = "\(newValue)"
        })
    }
}
