//
//  TextFieldView.swift
//  SparkCore
//
//  Created by louis.borlee on 07/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// A TextField that can be surrounded by left and/or right views
public struct TextFieldView<LeftView: View, RightView: View>: View {

    @ScaledMetric private var height: CGFloat = 44
    @ScaledMetric private var scaleFactor: CGFloat = 1.0

    @FocusState private var isFocused: Bool
    @ObservedObject var viewModel: TextFieldViewModel

    private let titleKey: LocalizedStringKey
    @Binding private var text: String
    private var type: TextFieldViewType

    private let leftView: () -> LeftView
    private let rightView: () -> RightView

    init(titleKey: LocalizedStringKey,
         text: Binding<String>,
         viewModel: TextFieldViewModel,
         type: TextFieldViewType,
         leftView: @escaping (() -> LeftView),
         rightView: @escaping (() -> RightView)) {
        self.titleKey = titleKey
        self._text = text
        self.viewModel = viewModel
        self.type = type
        self.leftView = leftView
        self.rightView = rightView
    }

    init(
        _ titleKey: LocalizedStringKey,
        text: Binding<String>,
        theme: Theme,
        intent: TextFieldIntent,
        borderStyle: TextFieldBorderStyle,
        type: TextFieldViewType,
        isReadOnly: Bool,
        leftView: @escaping (() -> LeftView),
        rightView: @escaping (() -> RightView)
    ) {
        let viewModel = TextFieldViewModel(
            theme: theme,
            intent: intent,
            borderStyle: borderStyle
        )
        viewModel.isUserInteractionEnabled = isReadOnly != true
        self.init(
            titleKey: titleKey,
            text: text,
            viewModel: viewModel,
            type: type,
            leftView: leftView,
            rightView: rightView
        )
    }
    
    /// TextFieldView initializer
    /// - Parameters:
    ///   - titleKey: The textfield's current placeholder
    ///   - text: The textfield's text binding
    ///   - theme: The textfield's current theme
    ///   - intent: The textfield's current intent
    ///   - type: The type of field with its associated callback(s), default is `.standard()`
    ///   - isReadOnly: Set this to true if you want the textfield to be readOnly, default is `false`
    ///   - leftView: The TextField's left view, default is `EmptyView`
    ///   - rightView: The TextField's right view, default is `EmptyView`
    public init(_ titleKey: LocalizedStringKey,
                text: Binding<String>,
                theme: Theme,
                intent: TextFieldIntent,
                type: TextFieldViewType = .standard(),
                isReadOnly: Bool = false,
                leftView: @escaping () -> LeftView = { EmptyView() },
                rightView: @escaping () -> RightView = { EmptyView() }) {
        self.init(
            titleKey,
            text: text,
            theme: theme,
            intent: intent,
            borderStyle: .roundedRect,
            type: type,
            isReadOnly: isReadOnly,
            leftView: leftView,
            rightView: rightView
        )
    }

    public var body: some View {
        ZStack {
            self.viewModel.backgroundColor.color
            contentViewBuilder()
                .padding(EdgeInsets(top: .zero, leading: self.viewModel.leftSpacing, bottom: .zero, trailing: self.viewModel.rightSpacing))
        }
        .tint(self.viewModel.textColor.color)
        .isEnabledChanged { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
        .allowsHitTesting(self.viewModel.isUserInteractionEnabled)
        .focused($isFocused)
        .onChange(of: isFocused) { newValue in
            self.viewModel.isFocused = newValue
        }
        .border(width: self.viewModel.borderWidth * self.scaleFactor, radius: self.viewModel.borderRadius, colorToken: self.viewModel.borderColor)
        .frame(height: self.height)
        .opacity(self.viewModel.dim)
    }

    // MARK: - Content
    @ViewBuilder
    private func contentViewBuilder() -> some View {
        HStack(spacing: self.viewModel.contentSpacing) {
            leftView()
            Group {
                switch type {
                case .secure(let onCommit):
                    SecureField(titleKey, text: $text, onCommit: onCommit)
                        .font(self.viewModel.font.font)
                case .standard(let onEditingChanged, let onCommit):
                    TextField(titleKey, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                        .font(self.viewModel.font.font)
                }
            }
            .textFieldStyle(.plain)
            .foregroundStyle(self.viewModel.textColor.color)
            rightView()
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(TextFieldAccessibilityIdentifier.view)
    }
}
