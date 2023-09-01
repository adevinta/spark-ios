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
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    @State private var isThemePresented = false

    let themes = ThemeCellModel.themes

    @State var intent: ChipIntent = .main
    @State var isIntentPresented = false
    @State var variant: ChipVariant = .filled
    @State var isVariantPresented = false
    @State var alignment: ChipAlignment = .leadingIcon
    @State var isAlignmentPressed = false

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
                HStack() {
                    Text("Theme: ").bold()
                    let selectedTheme = self.theme is SparkTheme ? themes.first : themes.last
                    Button(selectedTheme?.title ?? "") {
                        self.isThemePresented = true
                    }
                    .confirmationDialog("Select a theme",
                                        isPresented: self.$isThemePresented) {
                        ForEach(themes, id: \.self) { theme in
                            Button(theme.title) {
                                themePublisher.theme = theme.theme
                            }
                        }
                    }
                    Spacer()
                }
                HStack() {
                    Text("Intent: ").bold()
                    Button(self.intent.name) {
                        self.isIntentPresented = true
                    }
                    .confirmationDialog("Select an intent", isPresented: self.$isIntentPresented) {
                        ForEach(ChipIntent.allCases, id: \.self) { intent in
                            Button(intent.name) {
                                self.intent = intent
                            }
                        }
                    }
                }
                HStack() {
                    Text("Chip Variant: ").bold()
                    Button(self.variant.name) {
                        self.isVariantPresented = true
                    }
                    .confirmationDialog("Select a variant", isPresented: self.$isVariantPresented) {
                        ForEach(ChipVariant.allCases, id: \.self) { variant in
                            Button(variant.name) {
                                self.variant = variant
                            }
                        }
                    }
                }
                HStack() {
                    Text("Alignment: ").bold()
                    Button(self.alignment.name) {
                        self.isAlignmentPressed = true
                    }
                    .confirmationDialog("Select an alignment", isPresented: self.$isAlignmentPressed) {
                        ForEach(ChipAlignment.allCases, id: \.self) { alignment in
                            Button(alignment.name) {
                                self.alignment = alignment
                            }
                        }
                    }
                }
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
