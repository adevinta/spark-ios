//
//  SnackbarDemoView.swift
//  SparkDemo
//
//  Created by louis.borlee on 19/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkSnackbar
import SparkButton

struct SnackbarDemoView: View {

    @State var theme: any Theme = SparkTheme.shared
    @State var intent: SnackbarIntent = .basic
    @State var type: SnackbarType?
    @State var variant: SnackbarVariant?
    @State var showImage: Bool = false

    @State var text: String = "This is the snackbar text"
    @State var buttonTitle: String = "Tap"

    @State var maxNumberOfLines: Int = 0

    @State var withLeftPadding: Bool = false
    @State var withRightPadding: Bool = false

    @FocusState var isFocused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                componentsConfiguration()
                content {
                    VStack(spacing: 16) {
                        modifiedSnackbar(emptySnackbar())
                        modifiedSnackbar(snackbarWithButton())
                        modifiedSnackbar(snackbarWithCustomView())
                    }
                }
                paddingConfiguration()
            }
            .lineLimit(self.maxNumberOfLines == 0 ? nil : self.maxNumberOfLines)
            .padding(12)
        }
    }

    @ViewBuilder private func componentsConfiguration() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ThemeSelector(theme: self.$theme)
            EnumSelector(
                title: "Intent",
                dialogTitle: "Select an intent",
                values: SnackbarIntent.allCases,
                value: self.$intent
            )
            OptionalEnumSelector(
                title: "Type",
                dialogTitle: "Select a type",
                values: SnackbarType.allCases,
                value: self.$type
            )
            OptionalEnumSelector(
                title: "Variant",
                dialogTitle: "Select a variant",
                values: SnackbarVariant.allCases,
                value: self.$variant
            )
            TextFieldView(
                "Snackbar text",
                text: self.$text,
                theme: self.theme,
                intent: .neutral
            )
            TextFieldView(
                "Button title",
                text: self.$buttonTitle,
                theme: self.theme,
                intent: .neutral
            )
            RangeSelector(
                title: "Maximum number of lines",
                range: 0...10,
                selectedValue: self.$maxNumberOfLines
            )
        }
    }

    @ViewBuilder private func content(_ content: @escaping () -> some View) -> some View {
        HStack {
            if withLeftPadding {
                paddingView()
            }
            content()
            if withRightPadding {
                paddingView()
            }
        }
    }

    @ViewBuilder private func paddingConfiguration() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            SwitchView(
                theme: self.theme,
                intent: .info,
                alignment: .left,
                isOn: self.$withLeftPadding
            )
            .text("With left padding")
            SwitchView(
                theme: self.theme,
                intent: .info,
                alignment: .left,
                isOn: self.$withRightPadding
            )
            .text("With right padding")
        }
    }

    @ViewBuilder private func emptySnackbar() -> SnackbarView<EmptyView> {
        SnackbarView(
            theme: self.theme,
            intent: self.intent,
            image: self.image()) {
                Text(self.text)
            }
    }

    @ViewBuilder private func snackbarWithButton() -> SnackbarView<ButtonView> {
        SnackbarView(
            theme: self.theme,
            intent: self.intent,
            image: self.image()) {
                Text(self.text)
            } button: { configuration in
                ButtonView(
                    theme: self.theme,
                    intent: configuration.intent,
                    variant: configuration.variant,
                    size: configuration.size,
                    shape: configuration.shape,
                    alignment: .leadingImage) {
                        self.showImage.toggle()
                    }
                    .title(self.buttonTitle, for: .normal)
            }
    }

    @ViewBuilder private func snackbarWithCustomView() -> SnackbarView<some View> {
        SnackbarView(
            theme: self.theme,
            intent: self.intent,
            image: self.image()) {
                Text(self.text)
            } button: { configuration in
                HStack {
                    IconButtonView(
                        theme: self.theme,
                        intent: .danger,
                        variant: .filled,
                        size: .large,
                        shape: .pill,
                        action: {
                            self.showImage.toggle()
                        }
                    )
                    .image(.init(systemName: "externaldrive"), for: .normal)
                    IconButtonView(
                        theme: self.theme,
                        intent: .success,
                        variant: .contrast,
                        size: .small,
                        shape: .square,
                        action: {
                            self.showImage.toggle()
                        }
                    )
                    .image(.init(systemName: "externaldrive.fill"), for: .normal)
                }
            }
    }

    private func modifiedSnackbar<T>(_ snackbar: SnackbarView<T>) -> SnackbarView<T> {
        var copy = snackbar
        if let variant {
            copy = copy.variant(variant)
        }
        if let type {
            copy = copy.type(type)
        }
        return copy
    }

    @ViewBuilder private func image() -> Image? {
        self.showImage ? Image(systemName: "info.square") : nil
    }

    @ViewBuilder func paddingView() -> some View {
        Color.blue
            .opacity(0.3)
            .frame(width: 75)
            .cornerRadius(8)
    }
}
