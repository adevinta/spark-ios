//
//  ChipComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct ChipComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ChipIntent = .main
    @State private var variant: ChipVariant = .filled
    @State private var alignment: ChipAlignment = .leadingIcon
    @State private var showLabel = CheckboxSelectionState.selected
    @State private var showIcon = CheckboxSelectionState.selected
    @State private var withAction = CheckboxSelectionState.selected
    @State private var withComponent = CheckboxSelectionState.unselected
    @State private var isEnabled = CheckboxSelectionState.selected

    @State private var showingAlert = false

    private let label = "Label"
    private let icon = UIImage(imageLiteralResourceName: "alert")

    // MARK: - View

    var body: some View {

        Component(
            name: "Chip",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: ChipIntent.allCases,
                    value: self.$intent)

                EnumSelector(
                    title: "Chip Variant",
                    dialogTitle: "Select a Chip Variant",
                    values: ChipVariant.allCases,
                    value: self.$variant)

                EnumSelector(
                    title: "Alignment",
                    dialogTitle: "Select an Alignment",
                    values: ChipAlignment.allCases,
                    value: self.$alignment)

                CheckboxView(
                    text: "With Label",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$showLabel
                )

                CheckboxView(
                    text: "With Icon",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$showIcon
                )

                CheckboxView(
                    text: "With Action",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$withAction
                )

                CheckboxView(
                    text: "With Extra Component",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$withComponent
                )

                CheckboxView(
                    text: "Is Enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )
            },
            integration: {
                ChipComponentViewRepresentable(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    alignment: self.alignment,
                    label: self.showLabel == .selected ? self.label : nil,
                    icon: self.showIcon == .selected ? self.icon : nil,
                    component: self.withComponent == .selected ? badge() : nil,
                    isEnabled: self.isEnabled == .selected,
                    action: self.withAction == .selected ? { self.showingAlert = true} : nil)
                    .alert("Chip Pressed", isPresented: self.$showingAlert) {
                        Button("OK", role: .cancel) { }
                }
                .fixedSize()
            }
        )
    }

    func badge() -> UIView {
        return BadgeUIView(theme: self.theme,
                           intent: .danger,
                           size: .small,
                           value: 99
        )
    }
}

struct ChipComponent_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentView()
    }
}
