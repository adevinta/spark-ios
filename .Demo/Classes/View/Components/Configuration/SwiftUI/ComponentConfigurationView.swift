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
    @State private var dynamicTypeSize = DynamicTypeSize.medium
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
        VStack(spacing: .large) {
            self.componentView()
                .dynamicTypeSize(self.dynamicTypeSize)

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
                                selectedValue: $configuration.theme
                            )

                            self.itemsView()
                            // *****

                            Divider()

                            // *****
                            // Accessibility properties
                            if configuration.isAccessibilityLabel {
                                TextFieldConfigurationView(
                                    name: "Accessibility Label",
                                    text: self.$configuration.accessibilityLabel
                                )
                            }

                            if configuration.isAccessibilityValue {
                                TextFieldConfigurationView(
                                    name: "Accessibility Value",
                                    text: self.$configuration.accessibilityValue
                                )
                            }
                            // *****

                            Divider()

                            // *****
                            // Settings properties (just for sheet)
                            DynamicTypeConfigurationView(selectedValue: self.$dynamicTypeSize)
                            ColorSchemeConfigurationView(selectedValue: self.$colorScheme)
                            // *****
                        }

                        Button("Dismiss") {
                            self.dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.top, .large)
        .padding(.horizontal, .medium)
        .frame(maxWidth: .infinity)
        .preferredColorScheme(self.colorScheme)
    }
}
