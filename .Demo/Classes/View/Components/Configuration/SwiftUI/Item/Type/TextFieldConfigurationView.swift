//
//  TextFieldConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct TextFieldConfigurationView: View {

    // MARK: - Properties

    let name: String
    let text: Binding<String>
    var keyboardType: UIKeyboardType = .default

    @FocusState private var focusedField: Bool

    // MARK: - View

    var body: some View {
        ItemConfigurationView(name: self.name, spacing: .small) {
            TextField(
                name: self.name,
                text: self.text,
                keyboardType: self.keyboardType
            )
        }
    }
}

struct TextField: View {

    // MARK: - Properties

    let name: String
    let text: Binding<String>
    var keyboardType: UIKeyboardType = .default

    @FocusState private var focusedField: Bool

    var body: some View {
        SwiftUI.TextField(self.name, text: self.text)
            .padding(.vertical, .xSmall)
            .padding(.horizontal, .small)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .keyboardType(self.keyboardType)
            .focused(self.$focusedField)
            .toolbarIfNeeded(
                from: self.keyboardType,
                focused: self.$focusedField,
                action: {
                    self.focusedField = false
                })
    }
}

// MARK: - Extension

private extension View {

    @ViewBuilder
    func toolbarIfNeeded(
        from keyboardType: UIKeyboardType,
        focused: FocusState<Bool>.Binding,
        action: @escaping () -> Void
    ) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if keyboardType != .default, focused.wrappedValue {
                    Spacer()
                    Button("Done", action: action)
                }
            }
        }
    }
}
