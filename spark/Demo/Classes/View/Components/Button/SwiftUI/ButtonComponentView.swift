//
//  ButtonComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct ButtonComponentView: View {

    // MARK: - Properties

    private let viewModel = ButtonComponentViewModel()

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ButtonIntent = .main
    @State private var variant: ButtonVariant = .filled
    @State private var size: ButtonSize = .medium
    @State private var shape: ButtonShape = .rounded
    @State private var alignment: ButtonAlignment = .leadingIcon
    @State private var content: ButtonContentDefault = .text
    @State private var isEnabled: CheckboxSelectionState = .selected

    @State private var shouldShowReverseBackgroundColor: Bool = false

    // MARK: - View

    var body: some View {
        Component(
            name: "Button",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: ButtonIntent.allCases,
                    value: self.$intent
                )
                .onChange(of: self.intent) { newValue in
                    self.shouldShowReverseBackgroundColor = (newValue == .surface)
                }

                EnumSelector(
                    title: "Variant",
                    dialogTitle: "Select a variant",
                    values: ButtonVariant.allCases,
                    value: self.$variant
                )

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a size",
                    values: ButtonSize.allCases,
                    value: self.$size
                )

                EnumSelector(
                    title: "Shape",
                    dialogTitle: "Select a shape",
                    values: ButtonShape.allCases,
                    value: self.$shape
                )

                EnumSelector(
                    title: "Alignment",
                    dialogTitle: "Select an alignment",
                    values: ButtonAlignment.allCases,
                    value: self.$alignment
                )

                EnumSelector(
                    title: "Content",
                    dialogTitle: "Select an content",
                    values: ButtonContentDefault.allCases,
                    value: self.$content
                )

                CheckboxView(
                    text: "Is enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: self.theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )
            },
            integration: {
                GeometryReader { geometry in
                    ButtonComponentItemsUIView(
                        viewModel: self.viewModel,
                        width: geometry.size.width,
                        height: self.$uiKitViewHeight,
                        intent: self.$intent.wrappedValue,
                        variant: self.$variant.wrappedValue,
                        size: self.$size.wrappedValue,
                        shape: self.$shape.wrappedValue,
                        alignment: self.$alignment.wrappedValue,
                        content: self.$content.wrappedValue,
                        isEnabled: self.$isEnabled.wrappedValue == .selected
                    )
                    .frame(width: geometry.size.width, height: self.uiKitViewHeight, alignment: .center)
                    .padding(.horizontal, self.shouldShowReverseBackgroundColor ? 4 : 0)
                    .padding(.vertical, self.shouldShowReverseBackgroundColor ? 4 : 0)
                    .background(self.shouldShowReverseBackgroundColor ? Color.gray : Color.clear)
                }
                Spacer()
            }
        )
    }
}

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponentView()
    }
}
