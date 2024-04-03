//
//  TextFieldComponentView.swift
//  Spark
//
//  Created by louis.borlee on 08/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

// swiftlint:disable no_debugging_method
struct TextFieldComponentView: View {

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TextFieldIntent = .neutral

    @State private var isEnabledState: CheckboxSelectionState = .selected
    @State private var isSecureState: CheckboxSelectionState = .unselected
    @State private var isReadOnlyState: CheckboxSelectionState = .unselected

    @State private var leftViewContent: TextFieldSideViewContent = .none
    @State private var rightViewContent: TextFieldSideViewContent = .none

    @FocusState private var isFocusedState: Bool

    @State private var isShowingLeftAlert: Bool = false
    @State private var isShowingRightAlert: Bool = false

    @State var text: String = "Hello"

    var body: some View {
        Component(
            name: "TextField",
            configuration: {
                ThemeSelector(theme: self.$theme)
                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: TextFieldIntent.allCases,
                    value: self.$intent
                )
                EnumSelector(
                    title: "LeftView",
                    dialogTitle: "Select LeftView content",
                    values: TextFieldSideViewContent.allCases,
                    value: self.$leftViewContent
                )
                EnumSelector(
                    title: "RightView",
                    dialogTitle: "Select RightView content",
                    values: TextFieldSideViewContent.allCases,
                    value: self.$rightViewContent
                )
                Checkbox(title: "IsEnabled", selectionState: $isEnabledState)
                Checkbox(title: "IsSecure", selectionState: $isSecureState)
                Checkbox(title: "IsReadOnly", selectionState: $isReadOnlyState)
            },
            integration: {
                SparkCore.TextFieldView(
                    "Placeholder",
                    text: $text,
                    theme: self.theme,
                    intent: self.intent,
                    type: self.getTypeFromIsSecure(),
                    isReadOnly: self.isReadOnlyState == .selected,
                    leftView: {
                        self.view(side: .left)
                    },
                    rightView: {
                        self.view(side: .right)
                    }
                )
                .frame(maxWidth: .infinity)
                .disabled(self.isEnabledState == .unselected)
                .focused($isFocusedState)
                .onSubmit {
                    self.isFocusedState = false
                }
            }
        )
    }

    private func getTypeFromIsSecure() -> TextFieldViewType {
        switch isSecureState {
        case .selected:
            return .secure {
                print("Secure: On commit called")
            }
        case .indeterminate, .unselected:
            return .standard { isEditing in
                print("Standard: On editing changed called with isEditing \(isEditing)")
            } onCommit: {
                print("Standard: On commit called")
            }
        }
    }

    enum ContentSide: String {
        case left
        case right
    }

    @ViewBuilder
    private func view(side: ContentSide) -> some View {
        Group {
            let content = side == .left ? self.leftViewContent : self.rightViewContent
            switch content {
            case .none: EmptyView()
            case .button:
                createButton(side: side)
            case .text:
                createText(side: side)
            case .image:
                createImage(side: side)
            case .all:
                HStack(spacing: 6) {
                    createButton(side: side)
                    createImage(side: side)
                    createText(side: side)
                }
            }
        }
    }

    @ViewBuilder
    private func createImage(side: ContentSide) -> some View {
        let imageName = side == .right ? "delete.left" : "command"
        Image(systemName: imageName)
            .foregroundStyle(side == .left ? Color.green : Color.purple)
    }

    @ViewBuilder
    private func createText(side: ContentSide) -> some View {
        Text("\(side.rawValue) text")
            .foregroundStyle(side == .left ? Color.orange : Color.teal)
    }

    @ViewBuilder
    private func createButton(side: ContentSide) -> some View {
        ButtonView(
            theme: self.theme,
            intent: side == .left ? .danger : .alert,
            variant: .filled,
            size: .small,
            shape: .pill,
            alignment: .leadingImage) {
                switch side {
                case .left:
                    self.isShowingLeftAlert = true
                case .right:
                    self.isShowingRightAlert = true
                }
            }
            .title("This is the \(side.rawValue) button", for: .normal)
        .alert(isPresented: side == .left ? self.$isShowingLeftAlert : self.$isShowingRightAlert) {
            Alert(title: Text("\(side.rawValue) button has been pressed"), message: nil, dismissButton: Alert.Button.cancel())
        }
    }
}
