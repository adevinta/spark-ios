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

    private let titleKey: LocalizedStringKey
    private let text: Binding<String>
    private let type: TextFieldViewType
    private let viewModel: TextFieldViewModel
    private let leftView: () -> LeftView
    private let rightView: () -> RightView

    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    init(titleKey: LocalizedStringKey,
         text: Binding<String>,
         viewModel: TextFieldViewModel,
         type: TextFieldViewType,
         leftView: @escaping (() -> LeftView),
         rightView: @escaping (() -> RightView)) {
        self.titleKey = titleKey
        self.text = text
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
        TextFieldViewInternal(
            titleKey: self.titleKey,
            text: self.text,
            viewModel: self.viewModel,
            type: self.type,
            leftView: self.leftView,
            rightView: self.rightView)
        .update(
            isEnabled: self.isEnabled,
            isFocused: self.isFocused
        )
        .focused($isFocused)
    }

}
