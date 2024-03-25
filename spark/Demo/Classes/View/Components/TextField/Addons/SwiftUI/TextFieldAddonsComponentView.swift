//
//  TextFieldAddonsComponentView.swift
//  Spark
//
//  Created by louis.borlee on 21/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

// swiftlint:disable no_debugging_method
struct TextFieldAddonsComponentView: View {

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TextFieldIntent = .neutral

    @State private var isEnabledState: CheckboxSelectionState = .selected
    @State private var isSecureState: CheckboxSelectionState = .unselected
    @State private var isReadOnlyState: CheckboxSelectionState = .unselected
    @State private var withPaddingState: CheckboxSelectionState = .unselected

    @State private var leftViewContent: TextFieldSideViewContent = .none
    @State private var rightViewContent: TextFieldSideViewContent = .none

    @State private var leftAddonContent: TextFieldSideViewContent = .button
    @State private var rightAddonContent: TextFieldSideViewContent = .text

    @FocusState private var isFocusedState: Bool

    @State private var isShowingLeftAlert: Bool = false
    @State private var isShowingRightAlert: Bool = false

    @State var text: String = "Hello"

    var body: some View {
        Component(
            name: "TextFieldAddons",
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
                EnumSelector(
                    title: "LeftAddon",
                    dialogTitle: "Select LeftAddon content",
                    values: TextFieldSideViewContent.allCases,
                    value: self.$leftAddonContent
                )
                EnumSelector(
                    title: "RightAddon",
                    dialogTitle: "Select RightAddon content",
                    values: TextFieldSideViewContent.allCases,
                    value: self.$rightAddonContent
                )
                Checkbox(title: "IsEnabled", selectionState: $isEnabledState)
                Checkbox(title: "IsSecure", selectionState: $isSecureState)
                Checkbox(title: "IsReadOnly", selectionState: $isReadOnlyState)
                Checkbox(title: "WithPadding", selectionState: $withPaddingState)
            },
            integration: {
                SparkCore.TextFieldAddons(
                    "Placeholder",
                    text: $text,
                    theme: self.theme,
                    intent: self.intent,
                    successImage: Image("check"),
                    alertImage: Image("alert"),
                    errorImage: Image("alert-circle"),
                    isSecure: self.isSecureState == .selected,
                    isReadOnly: self.isReadOnlyState == .selected,
                    leftView: {
                        self.view(side: .left)
                    },
                    rightView: {
                        self.view(side: .right)
                    },
                    leftAddon: {
                        TextFieldAddon(withPadding: withPaddingState == .selected) {
                            self.addon(side: .left)
                        }
                    },
                    rightAddon: {
                        TextFieldAddon(withPadding: withPaddingState == .selected) {
                            self.addon(side: .right)
                        }
                    }
                )
                .disabled(self.isEnabledState == .unselected)
                .focused($isFocusedState)
                .onSubmit {
                    self.isFocusedState = false
                }
            }
        )
    }

    enum ContentSide: String {
        case left
        case right
    }

    @ViewBuilder
    private func view(side: ContentSide) -> some View {
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

    @ViewBuilder
    private func addon(side: ContentSide) -> some View {
        let content = side == .left ? self.leftAddonContent : self.rightAddonContent
        switch content {
        case .none: EmptyView()
        case .button:
            createSparkButton(side: side)
        case .text:
            createText(side: side)
        case .image:
            createImage(side: side)
        case .all:
            HStack(spacing: 6) {
                createSparkButton(side: side)
                createImage(side: side)
                createText(side: side)
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
    private func createSparkButton(side: ContentSide) -> some View {
        ButtonView(
            theme: self.theme,
            intent: side == .left ? .danger : .info,
            variant: .tinted,
            size: .large,
            shape: .square,
            alignment: .trailingImage) {
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

    @ViewBuilder
    private func createButton(side: ContentSide) -> some View {
        Button {
            switch side {
            case .left:
                self.isShowingLeftAlert = true
            case .right:
                self.isShowingRightAlert = true
            }
        } label: {
            Text("This is the \(side.rawValue) button")
        }
        .buttonStyle(.bordered)
        .alert(isPresented: side == .left ? self.$isShowingLeftAlert : self.$isShowingRightAlert) {
            Alert(title: Text("\(side.rawValue) button has been pressed"), message: nil, dismissButton: Alert.Button.cancel())
        }
        .tint(side == .left ? .red : .blue)
    }
}
