//
//  TextFieldAddons.swift
//  SparkCore
//
//  Created by louis.borlee on 21/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// A Spark TextField that can be surrounded by left and/or right addons
public struct TextFieldAddons<LeftView: View, RightView: View, LeftAddon: View, RightAddon: View>: View {

    @ScaledMetric private var scaleFactor: CGFloat = 1.0
    @ScaledMetric private var maxHeight: CGFloat = 44.0
    @ObservedObject private var viewModel: TextFieldAddonsViewModel
    private let leftAddon: () -> TextFieldAddon<LeftAddon>
    private let rightAddon: () -> TextFieldAddon<RightAddon>

    private let titleKey: LocalizedStringKey
    @Binding private var text: String
    private var isSecure: Bool
    private let leftView: () -> LeftView
    private let rightView: () -> RightView

    /// TextFieldAddons initializer
    /// - Parameters:
    ///   - titleKey: The textfield's current placeholder
    ///   - text: The textfield's text binding
    ///   - theme: The textfield's current theme
    ///   - intent: The textfield's current intent
    ///   - successImage: Success image, will be shown in the rightView when intent = .success
    ///   - alertImage: Alert image, will be shown in the rightView when intent = .alert
    ///   - errorImage: Error image, will be shown in the rightView when intent = .error
    ///   - isSecure: Set this to true if you want a SecureField, default is `false`
    ///   - isReadOnly: Set this to true if you want the textfield to be readOnly, default is `false`
    ///   - leftView: The TextField's left view, default is `EmptyView`
    ///   - rightView: The TextField's right view, default is `EmptyView`
    ///   - leftAddon: The TextField's left addon, default is `EmptyView`
    ///   - rightAddon: The TextField's right addon, default is `EmptyView`
    public init(
        _ titleKey: LocalizedStringKey,
        text: Binding<String>,
        theme: Theme,
        intent: TextFieldIntent,
        successImage: Image,
        alertImage: Image,
        errorImage: Image,
        isSecure: Bool,
        isReadOnly: Bool,
        leftView: @escaping (() -> LeftView) = { EmptyView() },
        rightView: @escaping (() -> RightView) = { EmptyView() },
        leftAddon: @escaping (() -> TextFieldAddon<LeftAddon>) = { .init(withPadding: false) { EmptyView() } },
        rightAddon: @escaping (() -> TextFieldAddon<RightAddon>) = { .init(withPadding: false) { EmptyView() } }
    ) {
        let viewModel = TextFieldAddonsViewModel(
            theme: theme,
            intent: intent,
            successImage: .right(successImage),
            alertImage: .right(alertImage),
            errorImage: .right(errorImage)
        )
        self.viewModel = viewModel

        self.titleKey = titleKey
        self._text = text
        self.isSecure = isSecure
        self.leftView = leftView
        self.rightView = rightView
        self.leftAddon = leftAddon
        self.rightAddon = rightAddon

        self.viewModel.textFieldViewModel.isUserInteractionEnabled = isReadOnly != true
    }

    private func getLeftAddonPadding(withPadding: Bool) -> EdgeInsets {
        guard withPadding else { return .init(all: 0) }
        return .init(
            top: .zero,
            leading: self.viewModel.leftSpacing,
            bottom: .zero,
            trailing: self.viewModel.leftSpacing
        )
    }

    private func getRightAddonPadding(withPadding: Bool) -> EdgeInsets {
        guard withPadding else { return .init(all: 0) }
        return .init(
            top: .zero,
            leading: self.viewModel.rightSpacing,
            bottom: .zero,
            trailing: self.viewModel.rightSpacing
        )
    }

    private func getContentPadding() -> EdgeInsets {
        return EdgeInsets(
            top: .zero,
            leading: LeftAddon.self is EmptyView.Type ? self.viewModel.leftSpacing : .zero,
            bottom: .zero, 
            trailing: RightAddon.self is EmptyView.Type ? self.viewModel.rightSpacing : .zero
        )
    }

    public var body: some View {
        ZStack {
            self.viewModel.backgroundColor.color
            let leftAddon = leftAddon()
            let rightAddon = rightAddon()
            HStack(spacing: self.viewModel.contentSpacing) {
                if LeftAddon.self is EmptyView.Type == false {
                    HStack(spacing: 0) {
                        leftAddon
                            .padding(getLeftAddonPadding(withPadding: leftAddon.withPadding))
                        separator()
                    }
                    .layoutPriority(leftAddon.layoutPriority)
                }
                textField()
                if RightAddon.self is EmptyView.Type == false {
                    HStack(spacing: 0) {
                        separator()
                        rightAddon
                            .padding(getRightAddonPadding(withPadding: rightAddon.withPadding))
                    }
                    .layoutPriority(leftAddon.layoutPriority)
                }
            }
            .padding(getContentPadding())
        }
        .frame(maxHeight: maxHeight)
        .allowsHitTesting(self.viewModel.textFieldViewModel.isUserInteractionEnabled)
        .border(width: self.viewModel.borderWidth * self.scaleFactor, radius: self.viewModel.borderRadius, colorToken: self.viewModel.textFieldViewModel.borderColor)
        .opacity(self.viewModel.dim)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(TextFieldAddonsAccessibilityIdentifier.view)
    }

    @ViewBuilder
    private func separator() -> some View {
        self.viewModel.textFieldViewModel.borderColor.color
            .frame(width: self.viewModel.borderWidth * self.scaleFactor)
    }

    @ViewBuilder
    private func textField() -> TextFieldView<LeftView, RightView> {
        TextFieldView(titleKey: titleKey, text: $text, viewModel: viewModel.textFieldViewModel, isSecure: isSecure, leftView: leftView, rightView: rightView)
    }
}
