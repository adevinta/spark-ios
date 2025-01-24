//
//  ComponentConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentConfigurationView<ComponentView: View, ConfigurationItemsView: View, Configuration: ComponentConfiguration>: View {

    // MARK: - Properties

    @Environment(\.dismiss) var dismiss
    @Binding var configuration: Configuration
    @State private var dynamicTypeSize = DynamicTypeSize.large
    @State private var colorScheme: ColorScheme = .light

    var componentView: () -> ComponentView
    var itemsView: () -> ConfigurationItemsView

    // MARK: - Initialization

    init(
        configuration: Binding<Configuration>,
        @ViewBuilder componentView: @escaping () -> ComponentView,
        @ViewBuilder itemsView: @escaping () -> ConfigurationItemsView
    ) {
        self._configuration = configuration
        self.componentView = componentView
        self.itemsView = itemsView
    }

    // MARK: - View

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: .large) {

                self.componentView()
                    .dynamicTypeSize(self.dynamicTypeSize)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: .medium) {
                    Text("Configuration")
                        .font(.title2)
                        .bold()

                    ScrollView {
                        VStack(alignment: .center, spacing: .xxLarge) {

                            VStack(alignment: .leading, spacing: .small) {
                                // *****
                                // Component properties
                                EnumConfigurationView(
                                    name: "theme",
                                    values: Themes.allCases,
                                    selectedValue: self.$configuration.theme
                                )

                                self.itemsView()

                                ToggleConfigurationView(
                                    name: "is enabled",
                                    isOn: self.$configuration.isEnabled.value
                                )
                                // *****

                                Divider()

                                // Accessibility properties
                                self.createAccessibilityProperties()

                                Divider()

                                // Size properties
                                self.createSizeProperties()

                                Divider()

                                // Settings properties (just for sheet)
                                self.createSettingsProperties()
                            }

                            Button("Dismiss") {
                                self.dismiss()
                            }

                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, .large)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.top, .large)
            .padding(.horizontal, .medium)
            .frame(maxWidth: .infinity)
            .preferredColorScheme(self.colorScheme)
        }
    }

    // MARK: - Builder

    @ViewBuilder
    func createAccessibilityProperties() -> some View {
        if self.configuration.accessibilityLabel.showConfiguration {
            TextFieldConfigurationView(
                name: "Accessibility Label",
                text: self.$configuration.accessibilityLabel.value
            )
        }

        if self.configuration.accessibilityValue.showConfiguration {
            TextFieldConfigurationView(
                name: "Accessibility Value",
                text: self.$configuration.accessibilityValue.value
            )
        }
    }

    @ViewBuilder
    func createSizeProperties() -> some View {
        let configurations = [
            self.$configuration.width,
            self.$configuration.height
        ]

        ForEach(configurations, id: \.id) { $item in
            if item.showConfiguration {
                HStack {
                    TextFieldConfigurationView(
                        name: item.name,
                        text: $item.text,
                        keyboardType: .numberPad
                    )

                    VStack {

                        TextField(
                            name: "Min",
                            text: $item.minText,
                            keyboardType: .numberPad
                        )

                        HStack {
                            TextField(
                                name: "Max",
                                text: $item.maxText,
                                keyboardType: .numberPad
                            )
                            
                            ToggleConfigurationView(
                                name: "∞",
                                isOn: $item.infinite
                            )
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func createSettingsProperties() -> some View {
        DynamicTypeConfigurationView(selectedValue: self.$dynamicTypeSize)
        ColorSchemeConfigurationView(selectedValue: self.$colorScheme)
    }
}
