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

    let viewModel = ButtonComponentViewModel()

    @State private var uiKitViewHeight: CGFloat = .zero

    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State var intent: ButtonIntent = .main
    @State var variant: ButtonVariant = .filled
    @State var size: ButtonSize = .medium
    @State var shape: ButtonShape = .rounded
    @State var alignment: ButtonAlignment = .leadingIcon
    @State var content: ButtonContentDefault = .text
    @State var isEnabled: CheckboxSelectionState = .selected

    @State var shouldShowReverseBackgroundColor: Bool = false

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
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
                        state: .enabled,
                        selectionState: self.$isEnabled
                    )
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

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
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Button"))
    }
}

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponentView()
    }
}
