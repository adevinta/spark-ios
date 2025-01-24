//
//  TextEditorComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct TextEditorComponentView: View {

    // MARK: - Properties

    @State private var configurations: [TextEditorConfiguration] = [.init()]
    @State private var showAlertAction = false
    @ScaledMetric private var scaleFactor: CGFloat = 1.0

    // MARK: - View

    var body: some View {
        ComponentDisplayView(
            configurations: self.configurations,
            style: .alone,
            styles: [.alone, .horizontalContent],
            componentView: { configuration in
                self.component(for: configuration)
            },
            configurationView: { configuration in
                self.configurationView(for: configuration)
            }
        )
    }

    // MARK: - Component

    private func component(for configuration: Binding<TextEditorConfiguration>) -> some View {
        let wrapped = configuration.wrappedValue

        return TextEditorView(
            wrapped.placeholder,
            text: configuration.text,
            theme: wrapped.theme.value,
            intent: wrapped.intent
        )
        .disabled(!wrapped.isEnabled.value)
        .accessibilityLabel(wrapped.accessibilityLabel.value)
        .frame(from: wrapped)
    }

    // MARK: - Configuration

    private func configurationView(for configuration: Binding<TextEditorConfiguration>) -> some View {
        ComponentConfigurationView(
            configuration: configuration,
            componentView: {
                self.component(for: configuration)
            },
            itemsView: {
                EnumConfigurationView(
                    name: "intent",
                    values: TextEditorIntent.allCases,
                    selectedValue: configuration.intent
                )

                TextFieldConfigurationView(
                    name: "placeholder",
                    text: configuration.placeholder
                )
            }
        )
    }
}

// MARK: - Preview

struct TextEditorComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorComponentView()
    }
}
