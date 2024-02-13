//
//  ProgressTrackerComponent.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 13.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI

struct ProgressTrackerComponent: View {
    @State var theme = SparkThemePublisher.shared.theme
    @State var intent = ProgressTrackerIntent.basic
    @State var variant = ProgressTrackerVariant.outlined
    @State var size = ProgressTrackerSize.medium
    @State var numberOfPages: Int = 4
    @State var orientation = ProgressTrackerOrientation.horizontal
    @State private var showLabel = CheckboxSelectionState.selected
    @State private var label: String = "Lore"
    @State private var currentPageIndex: Int = 1

    var body: some View {
        Component(
            name: "Progress Tracker",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: ProgressTrackerIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Variant",
                    dialogTitle: "Select a variant",
                    values: ProgressTrackerVariant.allCases,
                    value: self.$variant
                )

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a size",
                    values: ProgressTrackerSize.allCases,
                    value: self.$size
                )

                EnumSelector(
                    title: "Orientation",
                    dialogTitle: "Select an orientation",
                    values: ProgressTrackerOrientation.allCases,
                    value: self.$orientation
                )

                CheckboxView(
                    text: "With Label",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$showLabel
                )

                HStack() {
                    Text("Label ").bold()
                    TextField(
                        "Value",
                        text: self.$label
                    )
                }
            },

            integration: {
                if self.showLabel == .selected {
                    ProgressTrackerView(
                        theme: self.theme,
                        intent: self.intent,
                        variant: self.variant,
                        size: self.size,
                        labels: (0..<self.numberOfPages).map(self.label(_:)),
                        orientation: self.orientation, 
                        currentPageIndex: self.$currentPageIndex
                    )

                } else {
                    ProgressTrackerView(
                        theme: self.theme,
                        intent: self.intent,
                        variant: self.variant,
                        size: self.size,
                        numberOfPages: self.numberOfPages,
                        orientation: self.orientation, 
                        currentPageIndex: self.$currentPageIndex
                    )
                }
            }
        )
    }

    private func label(_ index: Int) -> String {
        if self.label.isEmpty {
            return "\(index)"
        } else {
            return "\(self.label) \(index)"
        }
    }
}
