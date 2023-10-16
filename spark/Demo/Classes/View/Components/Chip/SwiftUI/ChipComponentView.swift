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
    private let icon = Image("alert")

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
                    state: .enabled,
                    selectionState: self.$showLabel
                )

                CheckboxView(
                    text: "With Icon",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$showIcon
                )

                CheckboxView(
                    text: "With Action",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$withAction
                )

                CheckboxView(
                    text: "With Extra Component",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$withComponent
                )

                CheckboxView(
                    text: "Is Enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isEnabled
                )
            },
            integration: {
                ChipView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    alignment: self.alignment,
                    icon: self.showIcon == .selected ? self.icon : nil,
                    title: self.showLabel == .selected ? self.label : nil,
                    action: self.withAction == .selected ? { self.showingAlert = true} : nil
                )
                .component(self.withComponent == .selected ? self.component() : nil)
                .disabled(self.isEnabled == .unselected)
                .alert("Chip Pressed", isPresented: self.$showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        )
    }


    private func component() -> AnyView {
        return AnyView(
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.gray)
        )
    }
}

struct ChipComponent_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentView()
    }
}

extension UIView {
    func withTint(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}

private extension ChipAlignment {
    var name: String {
        switch self {
        case .leadingIcon: return "Leading Icon"
        case .trailingIcon: return "Trailing Icon"
        @unknown default:
            return "Unknown"
        }
    }
}
