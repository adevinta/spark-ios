//
//  TextEditorComponentView.swift
//  SparkDemo
//
//  Created by alican.aycil on 20.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

// swiftlint:disable no_debugging_method
struct TextEditorComponentView: View {

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TextEditorIntent = .neutral
    @State var text: String = ""
    @State var placeholder: String? = "What is Lorem Ipsum?"
    @State private var textType: TextEditorContent = .none
    @State private var placeholderType: TextEditorContent = .short
    @State private var isEnabledState: CheckboxSelectionState = .selected
    @State private var isReadOnlyState: CheckboxSelectionState = .unselected
    @FocusState private var isFocused: Bool

    var body: some View {
        Component(
            name: "TextEditor",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "",
                    values: TextEditorIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Text Type",
                    dialogTitle: "",
                    values: TextEditorContent.allCases,
                    value: self.$textType
                )

                EnumSelector(
                    title: "PlaceHolder Type",
                    dialogTitle: "",
                    values: TextEditorContent.allCases,
                    value: self.$placeholderType
                )

                Checkbox(title: "IsEnabled", selectionState: $isEnabledState)

                Checkbox(title: "IsReadOnly", selectionState: $isReadOnlyState)
            },
            integration: {
                TextEditorView(
                    theme: self.theme,
                    intent: self.intent,
                    text: self.$text,
                    placeholder: self.$placeholder
                )
                .isReadOnly(self.isReadOnlyState == .selected)
                .frame(width: 300, height: 100)
                .onChange(of: self.textType) { type in
                    self.text = self.contentType(type)
                }
                .onChange(of: self.placeholderType) { type in
                    self.placeholder = self.contentType(type)
                }
                .focused(self.$isFocused)
                .disabled(self.isEnabledState == .unselected)
            }
        ).onTapGesture {
            self.isFocused = false
        }
    }

    private func contentType(_ value: TextEditorContent) -> String {
        switch value {
        case .none:
            return ""
        case .short:
            return "What is Lorem Ipsum?"
        case .medium:
            return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        case .long:
            return "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        }
    }
}
