//
//  SpinnerComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct SpinnerComponent: View {

    @State var theme: Theme = SparkThemePublisher.shared.theme

    @State var intent: SpinnerIntent = .main
    @State var spinnerSize: SpinnerSize = .medium

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)

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

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

            SpinnerView(theme: self.theme,
                        intent: self.intent,
                        spinnerSize: self.spinnerSize
            )

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Spinner"))
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}
