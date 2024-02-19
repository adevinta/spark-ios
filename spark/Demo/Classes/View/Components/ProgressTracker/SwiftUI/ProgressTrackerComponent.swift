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
    @State private var frame = 0

    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.multiplier = 150
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()

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

                RangeSelector(
                    title: "Frame width/height",
                    range: 0...3,
                    selectedValue: self.$frame,
                    numberFormatter: self.numberFormatter
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
                let view = self.progressTrackerView()
                if self.frame == 0 {
                    view
                } else if self.orientation == .horizontal {
                    view.frame(width: CGFloat(self.frame) * 150.0)
                        .background(.yellow)
                } else {
                    view.frame(height: CGFloat(self.frame) * 150.0)
                        .background(.green)
                }
            }
        )
    }

    private func progressTrackerView() -> ProgressTrackerView {
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

    private func label(_ index: Int) -> String {
        if self.label.isEmpty {
            return "\(index)"
        } else {
            return "\(self.label) \(index)"
        }
    }
}
