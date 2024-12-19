//
//  StepperDemoView.swift
//  SparkDemo
//
//  Created by louis.borlee on 02/12/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkStepper

struct StepperDemoView: View {

    @State var value: Float
    @State var isEnabled: CheckboxSelectionState = .selected

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                componentsConfiguration()
                VStack(spacing: 16) {
                    VStack(spacing: 16) {
                        Text("Range -100 100, format USD, custom decrement button, custom increment accessibility label")
                        StepperControl(
                            theme: SparkTheme.shared,
                            value: self.$value,
                            step: 0.5,
                            in: ClosedRange<Float>(uncheckedBounds: (-100, 100)),
                            format: .currency(code: "USD")
                        )
                        .incrementAccessibilityLabel("Custom Increment")
                        .stepperButtonsConfiguration(.init(decrement: .init(icon: .init(systemName: "rectangle.portrait.and.arrow.right"), intent: .success, variant: .tinted)))
                        .disabled(self.isEnabled != .selected)

                        Text("Range -20 20, custom increment button, custom decrement accessibility")
                        StepperControl(
                            theme: SparkTheme.shared,
                            value: self.$value,
                            step: 0.5,
                            in: ClosedRange<Float>(uncheckedBounds: (-20, 20))
                        )
                        .decrementAccessibilityLabel("Custom Decrement")
                    }
                    .stepperButtonsConfiguration(.init(increment: .init(icon: .init(systemName: "square.and.arrow.down.fill"), intent: .accent, variant: .filled)))
                    .disabled(self.isEnabled != .selected)
                    Text("Range 0 1, format %")
                    StepperControl(
                        theme: SparkTheme.shared,
                        value: self.$value,
                        step: 0.5,
                        in: ClosedRange<Float>(uncheckedBounds: (0, 1)),
                        format: .percent
                    )
                    .disabled(self.isEnabled != .selected)
                }
            }
            .padding(12)
        }
    }

    @ViewBuilder
    private func componentsConfiguration() -> some View {
        Checkbox(title: "IsEnabled", selectionState: self.$isEnabled)
    }
}
