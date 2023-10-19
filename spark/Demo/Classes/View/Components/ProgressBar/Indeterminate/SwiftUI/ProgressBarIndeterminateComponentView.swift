//
//  ProgressBarIndeterminateComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct ProgressBarIndeterminateComponentView: View {

    // MARK: - Type Alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ProgressBarIntent = .main
    @State private var shape: ProgressBarShape = .square
    @State private var isAnimating = CheckboxSelectionState.unselected

    // MARK: - View

    var body: some View {
        Component(
            name: "ProgressBarIndeterminate",
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

                CheckboxView(
                    text: "Is animated",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: self.theme,
                    state: .enabled,
                    selectionState: self.$isAnimating
                )
            },
            integration: {
                ProgressBarIndeterminateView(
                    theme: self.theme,
                    intent: self.intent,
                    shape: self.shape,
                    isAnimating: self.isAnimating == .selected
                )
            }
        )
    }
}

// MARK: - Preview

struct ProgressBarIndeterminateComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarIndeterminateComponentView()
    }
}
