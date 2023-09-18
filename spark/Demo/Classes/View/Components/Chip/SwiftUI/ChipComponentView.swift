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
    @State var theme: Theme = SparkThemePublisher.shared.theme

    @State var intent: ChipIntent = .main
    @State var variant: ChipVariant = .filled
    @State var alignment: ChipAlignment = .leadingIcon

    @State var showLabel = CheckboxSelectionState.selected
    @State var showIcon = CheckboxSelectionState.selected
    @State var withAction = CheckboxSelectionState.selected
    @State var withComponent = CheckboxSelectionState.unselected
    @State var isEnabled = CheckboxSelectionState.selected

    @State var showingAlert = false

    private let label = "Label"
    private let icon = UIImage(imageLiteralResourceName: "alert")

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)

            VStack(alignment: .leading, spacing: 8) {
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
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

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

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Chip"))
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
