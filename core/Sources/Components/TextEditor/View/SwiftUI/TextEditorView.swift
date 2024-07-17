//
//  TextEditorView.swift
//  SparkCore
//
//  Created by alican.aycil on 20.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

enum Field: Hashable {
        case text
        case none
}

public struct TextEditorView: View {

    @ScaledMetric private var minHeight: CGFloat = 44
    private var defaultTexEditorTopPadding: CGFloat = 8
    private var defaultTexEditorBottomPadding: CGFloat = 9
    private var defaultTexEditorHorizontalPadding: CGFloat = 5
    @ScaledMetric private var scaleFactor: CGFloat = 1.0

    @ObservedObject private var viewModel: TextEditorViewModel

    @Binding private var text: String
    private var titleKey: String
    @FocusState private var focusedField: Field?
    @Environment(\.isEnabled) private var isEnabled
    @State private var textEditorEnabled: Bool = true

    private var isPlaceholderTextHidden: Bool {
        return !self.titleKey.isEmpty && self.text.isEmpty
    }

    private var isPlaceholderHidden: Bool {
        if #available(iOS 16.0, *) {
            return self.isPlaceholderTextHidden || self.viewModel.isReadOnly
        } else {
            return self.isPlaceholderTextHidden || self.viewModel.isReadOnly || !self.isEnabled
        }
    }

    public init(
        _ titleKey: String = "",
        text: Binding<String>,
        theme: Theme,
        intent: TextEditorIntent = .neutral
    ) {
        let viewModel = TextEditorViewModel(
            theme: theme,
            intent: intent
        )
        self.viewModel = viewModel
        self._text = text
        self.titleKey = titleKey
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            self.viewModel.backgroundColor.color

            if #available(iOS 16.0, *) {
                self.placeHolderView()
                    .scrollIndicators(.never)
                self.textEditorView()
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.never)
            } else {
                self.placeHolderView()
                self.textEditorView()
            }
        }
        .frame(minHeight: self.minHeight)
        .border(width: self.viewModel.borderWidth * self.scaleFactor, radius: self.viewModel.borderRadius * self.scaleFactor, colorToken: self.viewModel.borderColor)
        .tint(self.viewModel.textColor.color)
        .allowsHitTesting(self.viewModel.isEnabled)
        .focused(self.$focusedField, equals: .text)
        .onChange(of: self.focusedField) { focusedField in
            self.viewModel.isFocused = focusedField == .text
        }
        .isEnabled(self.isEnabled) { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
        .onChange(of: self.viewModel.isEnabled) { isEnabled in
            if !isEnabled {
                self.focusedField = nil
            }
            self.textEditorEnabled = isEnabled
        }
        .onChange(of: self.viewModel.isReadOnly) { isReadOnly in
            if isReadOnly {
                self.focusedField = nil
            }
        }
        .onTapGesture {
            if !self.viewModel.isReadOnly {
                self.focusedField = .text
            }
        }
        .accessibilityElement()
        .accessibilityIdentifier(TextEditorAccessibilityIdentifier.view)
        .accessibilityLabel(self.titleKey)
        .accessibilityValue(self.text)
    }

    @ViewBuilder
    private func textEditorView() -> some View {
        TextEditor(text: $text)
            .font(self.viewModel.font.font)
            .foregroundStyle(self.viewModel.textColor.color)
            .padding(
                EdgeInsets(
                    top: .zero + self.scaleFactor,
                    leading: (self.viewModel.horizontalSpacing * self.scaleFactor - self.defaultTexEditorHorizontalPadding),
                    bottom: .zero + self.scaleFactor,
                    trailing: (self.viewModel.horizontalSpacing * self.scaleFactor - self.defaultTexEditorHorizontalPadding)
                )
            )
            .opacity(!self.isPlaceholderHidden || self.viewModel.isFocused ? 1 : 0)
            .accessibilityHidden(true)
            .environment(\.isEnabled, self.textEditorEnabled)
    }

    @ViewBuilder
    private func placeHolderView() -> some View {
        ScrollView {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(self.isPlaceholderTextHidden ? self.titleKey : self.$text.wrappedValue)
                        .textSelected(self.viewModel.isReadOnly)
                        .font(self.viewModel.font.font)
                        .foregroundStyle(self.isPlaceholderTextHidden ? self.viewModel.placeholderColor.color : self.viewModel.textColor.color)

                        .padding(
                            EdgeInsets(
                                top: self.defaultTexEditorTopPadding + self.scaleFactor,
                                leading: self.viewModel.horizontalSpacing * self.scaleFactor,
                                bottom: self.defaultTexEditorBottomPadding + self.scaleFactor,
                                trailing: self.viewModel.horizontalSpacing * self.scaleFactor
                            )
                        )
                        .opacity(self.isPlaceholderHidden ? 1 : 0)
                        .accessibilityHidden(true)

                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
            }
        }
    }

    public func isReadOnly(_ value: Bool) -> some View {
        self.viewModel.isReadOnly = value
        return self
    }
}

private extension View {

    func isEnabled(_ value: Bool, complition: @escaping (Bool) -> Void) -> some View {
        DispatchQueue.main.async {
            complition(value)
        }
        return self.disabled(!value)
    }

    @ViewBuilder
    func textSelected(_ isEnabled: Bool) -> some View {
        if isEnabled {
            self.textSelection(.enabled)
        } else {
            self.textSelection(.disabled)
        }
    }
}
