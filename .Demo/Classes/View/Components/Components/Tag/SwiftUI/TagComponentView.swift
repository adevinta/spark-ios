//
//  TagComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct TagComponentView: View {

    // MARK: - Properties

    @State private var configurations: [TagConfiguration] = [.init()]
    @State private var presentConfigurationID: String?

    // MARK: - View

    var body: some View {
        ComponentListView(
            configurations: self.configurations,
            componentView: { configuration in
                self.component(for: configuration)
            },
            configurationView: { configuration in
                self.configurationView(for: configuration)
            }
        )
    }

    // MARK: - Component

    private func component(for configuration: TagConfiguration) -> some View {
        TagView(
            theme: configuration.theme.value,
            intent: configuration.intent,
            variant: configuration.variant
        )
        .demoText(configuration)
        .demoIcon(configuration)
        .demoAccessibilityLabel(configuration)
    }

    // MARK: - Configuration

    private func configurationView(for configuration: Binding<TagConfiguration>) -> some View {
        ComponentConfigurationView(
            configuration: configuration,
            componentView: {
                self.component(for: configuration.wrappedValue)
            },
            itemsView: {
                EnumConfigurationView(
                    name: "intent",
                    values: TagIntent.allCases,
                    selectedValue: configuration.intent
                )

                EnumConfigurationView(
                    name: "variant",
                    values: TagVariant.allCases,
                    selectedValue: configuration.variant
                )

                OptionalEnumConfigurationView(
                    name: "icon",
                    values: Iconography.allCases,
                    selectedValue: configuration.icon
                )

                TextFieldConfigurationView(
                    name: "text",
                    text: configuration.text
                )

                ToggleConfigurationView(
                    name: "is attributed Text",
                    isOn: configuration.isAttributedText
                )
            }
        )
    }
}

// MARK: - TagView Extension

private extension TagView {

    func demoIcon(_ configuration: TagConfiguration) -> Self {
        if let icon = configuration.icon {
            return self.iconImage(Image(icon))
        } else {
            return self
        }
    }

    func demoText(_ configuration: TagConfiguration) -> Self {
        let text = configuration.text
        if text.isEmpty {
            return self.text(nil)
        } else if configuration.isAttributedText {
            return self.attributedText(text.demoAttributedString)
        } else {
            return self.text(text)
        }
    }

    func demoAccessibilityLabel(_ configuration: TagConfiguration) -> some View {
        let label = configuration.accessibilityLabel
        return self.accessibility(
            identifier: "Tag Identifier",
            label: label.isEmpty ? nil : label
        )
    }
}

// MARK: - Preview

struct TagComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentView()
    }
}
