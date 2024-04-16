//
//  FormFieldView.swift
//  SparkDemo
//
//  Created by alican.aycil on 18.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct FormFieldComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var feedbackState: FormFieldFeedbackState = .default
    @State private var componentStyle: FormFieldComponentStyle = .singleCheckbox
    @State private var titleStyle: FormFieldTextStyle = .text
    @State private var descriptionStyle: FormFieldTextStyle = .text
    @State private var isEnabled = CheckboxSelectionState.selected
    @State private var isTitleRequired = CheckboxSelectionState.unselected

    @State private var checkboxGroupItems: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Checkbox 1", id: "1", selectionState: .unselected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Checkbox 2", id: "2", selectionState: .selected, isEnabled: true),
    ]
    @State private var scrollableCheckboxGroupItems: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .unselected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", id: "2", selectionState: .selected, isEnabled: true),
    ]
    @State private var texfieldText: String = ""
    @State private var selectedID: Int? = 0
    @State private var rating: CGFloat = 2

    // MARK: - View

    var body: some View {

        Component(
            name: "FormField",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Feedback State",
                    dialogTitle: "Select an Feedback State",
                    values: FormFieldFeedbackState.allCases,
                    value: self.$feedbackState)

                EnumSelector(
                    title: "Title Style",
                    dialogTitle: "Select a Title Style",
                    values: FormFieldTextStyle.allCases,
                    value: self.$titleStyle)

                EnumSelector(
                    title: "Description Style",
                    dialogTitle: "Select an Description Style",
                    values: FormFieldTextStyle.allCases,
                    value: self.$descriptionStyle)

                EnumSelector(
                    title: "Component Style",
                    dialogTitle: "Select an Description Style",
                    values: FormFieldComponentStyle.allCases,
                    value: self.$componentStyle)

                CheckboxView(
                    text: "Is Enable",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )

                CheckboxView(
                    text: "Is Title Require",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isTitleRequired
                )
            },
            integration: {
                FormFieldView(
                    theme: self.theme,
                    component: {
                        self.component
                    },
                    feedbackState: self.feedbackState,
                    attributedTitle: self.setText(isTitle: true, textStyle: self.titleStyle),
                    attributedDescription: self.setText(isTitle: false, textStyle: self.descriptionStyle),
                    isTitleRequired: self.isTitleRequired == .selected ? true : false
                )
                .disabled(self.isEnabled == .selected ? false : true)
            }
        )
    }

    private func setText(isTitle: Bool, textStyle: FormFieldTextStyle) -> AttributedString? {
        switch textStyle {
        case .text:
            return AttributedString(stringLiteral: isTitle ? "Agreement" : "Your agreement is important to us.")
        case .multilineText:
            return AttributedString(stringLiteral: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
        case .attributeText:
            return AttributedString(self.attributeText)
        case .none:
            return nil
        }
    }

    private var attributeText: NSAttributedString {
        let attributeString = NSMutableAttributedString(
            string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            attributes: [.font: UIFont.italicSystemFont(ofSize: 18)]
        )
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font: UIFont(
                descriptor: UIFontDescriptor().withSymbolicTraits([.traitBold, .traitItalic]) ?? UIFontDescriptor(),
                size: 18
            ),
            .foregroundColor: UIColor.red
        ]
        attributeString.setAttributes(attributes, range: NSRange(location: 0, length: 11))
        return attributeString
    }

    @ViewBuilder
    var component: some View {

        switch self.componentStyle {
        case .basic:
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(width: 50, height: 100)

        case .singleCheckbox:
            // Single checkbox might be fixed
            CheckboxView(
                text: "Hello World",
                checkedImage: DemoIconography.shared.checkmark.image,
                theme: self.theme,
                intent: .success,
                selectionState: .constant(.selected)
            )
            .fixedSize(horizontal: false, vertical: true)

        case .verticalCheckbox:
            CheckboxGroupView(
                checkedImage: DemoIconography.shared.checkmark.image,
                items: self.$checkboxGroupItems,
                alignment: .left,
                theme: self.theme,
                accessibilityIdentifierPrefix: "checkbox-group"
            )

        case .horizontalCheckbox:
            CheckboxGroupView(
                checkedImage: DemoIconography.shared.checkmark.image,
                items: self.$checkboxGroupItems,
                layout: .horizontal,
                alignment: .left,
                theme: self.theme,
                intent: .support,
                accessibilityIdentifierPrefix: "checkbox-group"
            )

        case .horizontalScrollableCheckbox:
            CheckboxGroupView(
                checkedImage: DemoIconography.shared.checkmark.image,
                items: self.$scrollableCheckboxGroupItems,
                layout: .horizontal,
                alignment: .left,
                theme: self.theme,
                intent: .support,
                accessibilityIdentifierPrefix: "checkbox-group"
            )
            case .singleRadioButton:
                RadioButtonGroupView(
                    theme: self.theme,
                    intent: .accent,
                    selectedID: self.$selectedID,
                    items: [
                        RadioButtonItem(id: 0, label: "Radio Button 1")
                    ],
                    labelAlignment: .trailing
                )
            case .verticalRadioButton:
                RadioButtonGroupView(
                    theme: self.theme,
                    intent: .danger,
                    selectedID: self.$selectedID,
                    items: [
                        RadioButtonItem(id: 0, label: "Radio Button 1"),
                        RadioButtonItem(id: 1, label: "Radio Button 2"),
                    ],
                    labelAlignment: .leading
                )
            case .horizontalRadioButton:
                RadioButtonGroupView(
                    theme: self.theme,
                    intent: .danger,
                    selectedID: self.$selectedID,
                    items: [
                        RadioButtonItem(id: 0, label: "Radio Button 1"),
                        RadioButtonItem(id: 1, label: "Radio Button 2"),
                    ],
                    labelAlignment: .trailing,
                    groupLayout: .horizontal
                )
            case .textField:
                TextField("Component is not ready yet", text: self.$texfieldText)
                    .textFieldStyle(.roundedBorder)
            case .addOnTextField:
                TextField("Component is not ready yet", text: self.$texfieldText)
                    .textFieldStyle(.roundedBorder)
            case .ratingInput:
                RatingInputView(
                    theme: self.theme,
                    intent: .main,
                    rating: self.$rating
                )
        }
    }
}
