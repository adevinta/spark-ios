//
//  ProgressBarComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct ProgressBarComponentView: View {

    // MARK: - Type Alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ProgressBarIntent = .main
    @State private var shape: ProgressBarShape = .square
    @State var value = Constants.IndicatorValue.default

    // MARK: - View

    var body: some View {
        Component(
            name: "ProgressBar",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: ProgressBarIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Shape",
                    dialogTitle: "Select an shape",
                    values: ProgressBarShape.allCases,
                    value: self.$shape
                )

                RangeSelector(
                    title: "Value",
                    range: Constants.IndicatorValue.range,
                    selectedValue: self.$value,
                    stepper: Constants.IndicatorValue.stepper,
                    numberFormatter: Constants.IndicatorValue.numberFormatter
                )
            },
            integration: {
                ProgressBarView(
                    theme: self.theme,
                    intent: self.intent,
                    shape: self.shape,
                    value: CGFloat(self.value) * Constants.IndicatorValue.multiplier
                )
            }
        )
    }
}

// MARK: - Preview

struct ProgressBarComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarComponentView()
    }
}
