//
//  SpinnerComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct SpinnerComponent: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: SpinnerIntent = .main
    @State private var spinnerSize: SpinnerSize = .medium

    // MARK: - View

    var body: some View {
        Component(
            name: "Spinner",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: SpinnerIntent.allCases,
                    value: self.$intent)

                EnumSelector(
                    title: "Spinner Size",
                    dialogTitle: "Select a Size",
                    values: SpinnerSize.allCases,
                    value: self.$spinnerSize)
            },
            integration: {
                SpinnerView(
                    theme: self.theme,
                    intent: self.intent,
                    spinnerSize: self.spinnerSize
                )
            }
        )
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}
