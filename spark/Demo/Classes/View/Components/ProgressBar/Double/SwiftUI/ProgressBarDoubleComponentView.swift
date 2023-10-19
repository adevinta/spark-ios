//
//  ProgressBarDoubleComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

#warning("Keep this class commented until the design team decision about the Double Bar")
/*
import SwiftUI
import Spark
import SparkCore

struct ProgressBarDoubleComponentView: View {

    // MARK: - Type Alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ProgressBarDoubleIntent = .main
    @State private var shape: ProgressBarShape = .square
    @State var topValue = Constants.IndicatorValue.default
    @State var bottomValue = Constants.IndicatorValue.bottomDefault

    // MARK: - View

    var body: some View {
        Component(
            name: "ProgressBarDouble",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: ProgressBarDoubleIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Shape",
                    dialogTitle: "Select an shape",
                    values: ProgressBarShape.allCases,
                    value: self.$shape
                )

                RangeSelector(
                    title: "Top value",
                    range: Constants.IndicatorValue.range,
                    selectedValue: self.$topValue,
                    stepper: Constants.IndicatorValue.stepper,
                    numberFormatter: Constants.IndicatorValue.numberFormatter
                )

                RangeSelector(
                    title: "Bottom value",
                    range: Constants.IndicatorValue.range,
                    selectedValue: self.$bottomValue,
                    stepper: Constants.IndicatorValue.stepper,
                    numberFormatter: Constants.IndicatorValue.numberFormatter
                )
            },
            integration: {
                ProgressBarDoubleView(
                    theme: self.theme,
                    intent: self.intent,
                    shape: self.shape,
                    topValue: CGFloat(self.topValue) * Constants.IndicatorValue.multiplier,
                    bottomValue: CGFloat(self.bottomValue) * Constants.IndicatorValue.multiplier
                )
            }
        )
    }
}

// MARK: - Preview

struct ProgressBarDoubleComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarDoubleComponentView()
    }
}
*/
