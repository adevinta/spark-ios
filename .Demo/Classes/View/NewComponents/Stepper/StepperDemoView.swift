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
    @State var isEnabled: CheckboxSelectionState = .unselected

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                componentsConfiguration()
                VStack(spacing: 16) {
                    StepperView(
                        theme: SparkTheme.shared,
                        value: self.$value,
                        step: 0.5,
                        in: ClosedRange<Float>(uncheckedBounds: (-20, 20)),
                        format: .currency(code: "USD")
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
