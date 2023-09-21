//
//  SwitchComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct SwitchComponentView: View {

    // MARK: - Properties

    let viewModel = SwitchComponentViewModel()

    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State var isOn: Bool = true
    @State var alignment: SwitchAlignment = .left
    @State var intent: SwitchIntent = .main
    @State var isEnabled: CheckboxSelectionState = .selected
    @State var hasImages: CheckboxSelectionState = .unselected
    @State var textContent: SwitchTextContentDefault = .text

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
                        title: "Alignment",
                        dialogTitle: "Select an alignment",
                        values: SwitchAlignment.allCases,
                        value: self.$alignment
                    )

                    EnumSelector(
                        title: "Intent",
                        dialogTitle: "Select an intent",
                        values: SwitchIntent.allCases,
                        value: self.$intent
                    )

                    EnumSelector(
                        title: "Text content",
                        dialogTitle: "Select an text content",
                        values: SwitchTextContentDefault.allCases,
                        value: self.$textContent
                    )

                    CheckboxView(
                        text: "Is on",
                        checkedImage: DemoIconography.shared.checkmark,
                        theme: self.theme,
                        state: .enabled,
                        selectionState: Binding(
                            get: { self.isOn ? .selected : .unselected },
                            set: { self.isOn = ($0 == .selected) }
                        )
                    )

                    CheckboxView(
                        text: "Is enabled",
                        checkedImage: DemoIconography.shared.checkmark,
                        theme: self.theme,
                        state: .enabled,
                        selectionState: self.$isEnabled
                    )

                    CheckboxView(
                        text: "Has images",
                        checkedImage: DemoIconography.shared.checkmark,
                        theme: self.theme,
                        state: .enabled,
                        selectionState: self.$hasImages
                    )
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                SwitchView(
                    theme: self.theme,
                    isOn: self.$isOn
                )
                .alignment(self.alignment)
                .intent(self.intent)
                .isEnabled(self.isEnabled == .selected)
                .images(self.hasImages == .selected ? self.images() : nil)
                .textContent(
                    viewModel: self.viewModel,
                    textContent: self.textContent,
                    attributedText: self.attributedText()
                )

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Switch"))
    }

    // MARK: - UIKit

    private func images() -> SwitchImages {
        let onImage = Image(self.viewModel.onImageNamed)
        let offImage = Image(self.viewModel.offImageNamed)

        return SwitchImages(
            on: onImage,
            off: offImage
        )
    }

    private func attributedText() -> AttributedString {
        var attributedText = AttributedString(self.viewModel.text)
        attributedText.font = SparkTheme.shared.typography.body2.font
        attributedText.foregroundColor = SparkTheme.shared.colors.main.main.color
        attributedText.backgroundColor = SparkTheme.shared.colors.main.onMain.color
        return attributedText
    }
}

// MARK: - Modifier

extension SwitchView {

    func textContent(
        viewModel: SwitchComponentViewModel,
        textContent: SwitchTextContentDefault,
        attributedText: AttributedString
    ) -> SwitchView {
        switch textContent {
        case .text:
            return self.text(viewModel.text(isMultilineText: false))
        case .attributedText:
            return self.attributedText(attributedText)
        case .multilineText:
            return self.text(viewModel.text(isMultilineText: true))
        case .none:
            return self.text(nil).attributedText(nil)
        }
    }
}

// MARK: - Preview

struct SwitchComponentView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchComponentView()
    }
}
