//
//  IconButtonComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct IconButtonComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: ButtonIntent = .main
    @State private var variant: ButtonVariant = .filled
    @State private var size: ButtonSize = .medium
    @State private var shape: ButtonShape = .rounded
    private let contentNormal: IconButtonContentDefault = .image
    @State private var contentHighlighted: IconButtonContentDefault = .image
    @State private var contentDisabled: IconButtonContentDefault = .image
    @State private var contentSelected: IconButtonContentDefault = .image
    @State private var isEnabled: CheckboxSelectionState = .selected
    @State private var isSelected: CheckboxSelectionState = .unselected
    @State private var isToggle: CheckboxSelectionState = .unselected

    @State private var shouldShowReverseBackgroundColor: Bool = false

    @State private var showingActionAlert = false

    // MARK: - View

    var body: some View {
        Component(
            name: "Icon Button",
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
                    title: "Content (highlighted state)",
                    dialogTitle: "Select a highlighted content",
                    values: IconButtonContentDefault.allCases,
                    value: self.$contentHighlighted
                )

                EnumSelector(
                    title: "Content (disabled state)",
                    dialogTitle: "Select a disabled content",
                    values: IconButtonContentDefault.allCases,
                    value: self.$contentDisabled
                )

                EnumSelector(
                    title: "Content (selected state)",
                    dialogTitle: "Select a selected content",
                    values: IconButtonContentDefault.allCases,
                    value: self.$contentSelected
                )

                CheckboxView(
                    text: "Is enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: self.theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )

                CheckboxView(
                    text: "Is selected",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: self.theme,
                    isEnabled: true,
                    selectionState: self.$isSelected
                )

                CheckboxView(
                    text: "Is toggle",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: self.theme,
                    isEnabled: false,
                    selectionState: self.$isToggle
                )
            },
            integration: {
                IconButtonView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant,
                    size: self.size,
                    shape: self.shape,
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

private extension IconButtonView {

    // MARK: - UI

    func addImage(
        _ content: IconButtonContentDefault,
        state: ControlState) -> Self {
            var image: Image?
            if content == .image {
                switch state {
                case .normal: image = Image("arrow")
                case .highlighted: image = Image("close")
                case .disabled: image = Image("check")
                case .selected: image = Image("alert")
                @unknown default: break
                }
            }

            return self.image(image, for: state)
    }
}

// MARK: - Preview

struct IconButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonComponentView()
    }
}
