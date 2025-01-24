//
//  TextLinkComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 23/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

// TODO: Check to migrate sizeCategory in TextLink to dynamicTypeSize.

struct TextLinkComponentView: View {

    // MARK: - Properties

    @State private var configurations: [TextLinkConfiguration] = [.init()]
    @State private var showAlertAction = false

    // MARK: - View

    var body: some View {
        ComponentDisplayView(
            configurations: self.configurations,
            componentView: { configuration in
                self.component(for: configuration.wrappedValue)
            },
            configurationView: { configuration in
                self.configurationView(for: configuration)
            }
        )
    }

    // MARK: - Component

    private func component(for configuration: TextLinkConfiguration) -> some View {
        TextLinkView(
            theme: configuration.theme.value,
            text: configuration.getText(),
            textHighlightRange: configuration.getTextHighlightRange(),
            intent: configuration.intent,
            typography: configuration.typography,
            variant: configuration.variant,
            image: .init(configuration.icon),
            alignment: configuration.alignment,
            action: {
                self.showAlertAction = true
            }
        )
        .multilineTextAlignment(configuration.textAlignment)
        .lineLimit(configuration.numberOfLine > 0 ? configuration.numberOfLine : nil)
        .accessibilityLabel(configuration.accessibilityLabel.value)
        .accessibilityValue(configuration.accessibilityValue.value)
        .alertAction("TextLink tap", showAlert: self.$showAlertAction)
    }

    // MARK: - Configuration

    private func configurationView(for configuration: Binding<TextLinkConfiguration>) -> some View {
        ComponentConfigurationView(
            configuration: configuration,
            componentView: {
                self.component(for: configuration.wrappedValue)
            },
            itemsView: {
                EnumConfigurationView(
                    name: "intent",
                    values: TextLinkIntent.allCases,
                    selectedValue: configuration.intent
                )

                EnumConfigurationView(
                    name: "variant",
                    values: TextLinkVariant.allCases,
                    selectedValue: configuration.variant
                )

                EnumConfigurationView(
                    name: "typography",
                    values: TextLinkTypography.allCases,
                    selectedValue: configuration.typography
                )

                OptionalEnumConfigurationView(
                    name: "icon",
                    values: Iconography.allCases,
                    selectedValue: configuration.icon
                )

                ToggleConfigurationView(
                    name: "is long text",
                    isOn: configuration.isLongText
                )

                TextFieldConfigurationView(
                    name: "text",
                    text: configuration.text
                )

                EnumConfigurationView(
                    name: "alignment (content)",
                    values: TextLinkAlignment.allCases,
                    selectedValue: configuration.alignment
                )

                EnumConfigurationView(
                    name: "alignment (text)",
                    values: TextAlignment.allCases,
                    selectedValue: configuration.textAlignment
                )

                StepperConfigurationView(
                    name: "number of line",
                    value: configuration.numberOfLine,
                    bounds: 0...10,
                    step: 1
                )
            }
        )
    }
}

// MARK: - Preview

struct TextLinkComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TextLinkComponentView()
    }
}
