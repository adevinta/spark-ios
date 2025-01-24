//
//  TextFieldComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct TextFieldComponentView: View {

    // MARK: - Properties

    @State private var configurations: [TextFieldConfiguration] = [.init()]
    @State private var showAlertAction = false

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

    private func component(for configuration: Binding<TextFieldConfiguration>) -> some View {
        let wrapped = configuration.wrappedValue

        // TODO: left and right side are not updated !!!
        return TextFieldView(
            LocalizedStringKey(wrapped.placeholder),
            text: configuration.text,
            theme: wrapped.theme.value,
            intent: wrapped.intent,
            type: self.getType(from: wrapped),
            isReadOnly: wrapped.isReadOnly,
            leftView: {
                SideView(configuration: wrapped, side: .left)
            },
            rightView: {
                SideView(configuration: wrapped, side: .right)
            }
        )
        .disabled(!wrapped.isEnabled.value)
        .accessibilityLabel(wrapped.accessibilityLabel.value)
    }

    // MARK: - Configuration

    private func configurationView(for configuration: Binding<TextFieldConfiguration>) -> some View {
        ComponentConfigurationView(
            configuration: configuration,
            componentView: {
                self.component(for: configuration)
            },
            itemsView: {
                EnumConfigurationView(
                    name: "intent",
                    values: TextFieldIntent.allCases,
                    selectedValue: configuration.intent
                )

                TextFieldConfigurationView(
                    name: "placeholder",
                    text: configuration.placeholder
                )

                ToggleConfigurationView(
                    name: "is secure",
                    isOn: configuration.isSecure
                )

                ToggleConfigurationView(
                    name: "is read only",
                    isOn: configuration.isReadOnly
                )

                EnumConfigurationView(
                    name: "left view",
                    values: TextFieldSideViewContent.allCases,
                    selectedValue: configuration.leftViewContent
                )

                EnumConfigurationView(
                    name: "right view",
                    values: TextFieldSideViewContent.allCases,
                    selectedValue: configuration.rightViewContent
                )
            }
        )
    }

    // MARK: - Getter

    private func getType(from configuration: TextFieldConfiguration) -> TextFieldViewType {
        if configuration.isSecure {
            return .secure {
                print("Secure: On commit called")
            }
        } else {
            return .standard { isEditing in
                print("Standard: On editing changed called with isEditing \(isEditing)")
            } onCommit: {
                print("Standard: On commit called")
            }
        }
    }
}

// MARK: - Side View

private struct SideView: View {

    // MARK: - Properties

    let configuration: TextFieldConfiguration
    let side: TextFieldContentSide

    @State private var isShowingAlert: Bool = false

    // MARK: - View

    var body: some View {
        HStack {
            let content = self.side == .left ? self.configuration.leftViewContent : self.configuration.rightViewContent
            switch content {
            case .none: EmptyView()
            case .button:
                self.createButton()
            case .text:
                self.createText()
            case .image:
                self.createImage()
            case .all:
                HStack(spacing: 6) {
                    self.createButton()
                    self.createImage()
                    self.createText()
                }
            }
        }
    }

    private func createImage() -> some View {
        Image(self.side == .left ? Iconography.check : .warningFill)
            .foregroundStyle(self.side == .left ? .yellow : .purple)
    }

    private func createText() -> some View {
        Text("\(self.side.name) text")
            .foregroundStyle(self.side == .left ? Color.orange : Color.teal)
    }

    private func createButton() -> some View {
        ButtonView(
            theme: self.configuration.theme.value,
            intent: self.side == .left ? .danger : .alert,
            variant: .filled,
            size: .small,
            shape: .pill,
            alignment: .leadingImage) {
                self.isShowingAlert = true
            }
            .title(self.side.rawValue, for: .normal)
            .alert(isPresented: self.$isShowingAlert) {
                Alert(title: Text("\(self.side.rawValue) button has been pressed"), message: nil, dismissButton: Alert.Button.cancel())
            }
    }
}

// MARK: - Preview

struct TextFieldComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldComponentView()
    }
}
