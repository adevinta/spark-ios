//
//  IconComponentView.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct IconComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var size: IconSize = .medium
    @State private var intent: IconIntent = .main

    // MARK: - View

    var body: some View {
        Component(
            name: "Icon",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: IconIntent.allCases,
                    value: self.$intent)

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a Size",
                    values: IconSize.allCases,
                    value: self.$size)
            },
            integration: {
                IconView(
                    theme: SparkTheme.shared,
                    intent: self.intent,
                    size: self.size,
                    iconImage: Image("alert")
                )
            }
        )
    }
}

struct IconComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconComponentView()
    }
}
