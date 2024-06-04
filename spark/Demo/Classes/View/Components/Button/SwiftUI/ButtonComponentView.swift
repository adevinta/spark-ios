//
//  ButtonComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import Spark

struct ButtonComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ButtonIntent = .main
    @State private var variant: ButtonVariant = .filled
    @State private var size: ButtonSize = .medium
    @State private var shape: ButtonShape = .rounded
    @State private var alignment: ButtonAlignment = .leadingImage
    @State private var contentNormal: ButtonContentDefault = .text
    @State private var contentHighlighted: ButtonContentDefault = .text
    @State private var contentDisabled: ButtonContentDefault = .text
    @State private var contentSelected: ButtonContentDefault = .text
    @State private var isEnabled: CheckboxSelectionState = .selected
    @State private var isSelected: CheckboxSelectionState = .unselected
    @State private var isToggle: CheckboxSelectionState = .unselected
    @State private var isFullWidth: CheckboxSelectionState = .unselected

    @State private var shouldShowReverseBackgroundColor: Bool = false

    @State private var showingActionAlert = false

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
                    title: "Content (normal state)",
                    dialogTitle: "Select a normal content",
                    values: ButtonContentDefault.allCasesExceptNone,
                    value: self.$contentNormal
                )

                EnumSelector(
                    title: "Content (highlighted state)",
                    dialogTitle: "Select a highlighted content",
                    values: ButtonContentDefault.allCases,
                    value: self.$contentHighlighted
                )

                EnumSelector(
                    title: "Content (disabled state)",
                    dialogTitle: "Select a disabled content",
                    values: ButtonContentDefault.allCases,
                    value: self.$contentDisabled
                )

                EnumSelector(
                    title: "Content (selected state)",
                    dialogTitle: "Select a selected content",
                    values: ButtonContentDefault.allCases,
                    value: self.$contentSelected
                )

                CheckboxView(
                    text: "Is enabled",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: self.theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )

                CheckboxView(
                    text: "Is selected",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: self.theme,
                    isEnabled: true,
                    selectionState: self.$isSelected
                )

                CheckboxView(
                    text: "Is toggle",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: self.theme,
                    isEnabled: false,
                    selectionState: self.$isToggle
                )

                CheckboxView(
                    text: "Is full width",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: self.theme,
                    isEnabled: false,
                    selectionState: self.$isFullWidth
                )
            },
            integration: {
                ButtonView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    size: self.size,
                    shape: self.shape,
                    alignment: self.alignment,
                    action: {
                        if self.isToggle == .selected {
                            self.isSelected = (self.isSelected == .selected) ? .unselected : .selected
                        } else {
                            self.showingActionAlert = true
                        }
                    })
                .disabled(self.isEnabled == .unselected)
                .selected(self.isSelected == .selected)
                // Images
                .addImage(self.contentNormal, state: .normal)
                .addImage(self.contentHighlighted, state: .highlighted)
                .addImage(self.contentDisabled, state: .disabled)
                .addImage(self.contentSelected, state: .selected)
                // Attributed Titles or Titles
                .addContent(self.contentNormal, state: .normal)
                .addContent(self.contentHighlighted, state: .highlighted)
                .addContent(self.contentDisabled, state: .disabled)
                .addContent(self.contentSelected, state: .selected)
                .frame(maxWidth: self.isFullWidth == .selected ? .infinity : nil)
                .padding(.horizontal, self.shouldShowReverseBackgroundColor ? 4 : 0)
                .padding(.vertical, self.shouldShowReverseBackgroundColor ? 4 : 0)
                .background(self.shouldShowReverseBackgroundColor ? Color.gray : Color.clear)
                .alert("Button tap", isPresented: $showingActionAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        )
    }
}

// MARK: - Extension

private extension ButtonView {

    // MARK: - UI

    func addImage(
        _ content: ButtonContentDefault,
        state: ControlState) -> Self {
            var image: Image?
            if content.containsImage {
                switch state {
                case .normal: image = Image("arrow")
                case .highlighted: image = Image("close")
                case .disabled: image = Image("check")
                case .selected: image = Image("alert")
                }
            }

            return self.image(image, for: state)
    }

    func addContent(
        _ content: ButtonContentDefault,
        state: ControlState) -> Self {

            func attributedText(_ text: String) -> AttributedString {
                var string = AttributedString(text)
                string.font = .largeTitle
                string.foregroundColor = .purple
                string.font = .italicSystemFont(ofSize: 20)
                string.underlineStyle = .single
                string.underlineColor = .purple
                return string
            }

            var title: String?
            switch state {
            case .normal: title = "My Title"
            case .highlighted: title = "My Highlighted"
            case .disabled: title = "My Disabled"
            case .selected: title = "My Selected"
            }

            if content.containsAttributedText, let title {
                return self.attributedTitle(attributedText(title), for: state)
            } else if content.containsText {
                return self.title(title, for: state)
            } else {
                return self.title(nil, for: state)
            }
    }
}

// MARK: - Preview

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponentView()
    }
}
