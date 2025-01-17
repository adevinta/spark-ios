//
//  TextLinkComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct TextLinkComponentView: View {

    // MARK: - Type Alias

    private typealias Constants = TextLinkConstants

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TextLinkIntent = .basic
    @State private var variant: TextLinkVariant = .underline
    @State private var typography: TextLinkTypography = .body1
    @State private var content: TextLinkContent = .text
    @State private var contentAlignment: TextLinkAlignment = .leadingImage
    @State private var textAlignment: TextAlignment = .leading
    @State private var isLineLimit: CheckboxSelectionState = .unselected

    @State private var showIngActionAlert = false

    // MARK: - View

    var body: some View {
        Component(
            name: "TextLink",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: TextLinkIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Variant",
                    dialogTitle: "Select a variant",
                    values: TextLinkVariant.allCases,
                    value: self.$variant
                )

                EnumSelector(
                    title: "Typography",
                    dialogTitle: "Select a typography",
                    values: TextLinkTypography.allCases,
                    value: self.$typography
                )

                EnumSelector(
                    title: "Content",
                    dialogTitle: "Select a content",
                    values: TextLinkContent.allCases,
                    value: self.$content
                )

                EnumSelector(
                    title: "Alignment (Content)",
                    dialogTitle: "Select an alignment",
                    values: TextLinkAlignment.allCases,
                    value: self.$contentAlignment
                )

                EnumSelector(
                    title: "Alignment (Text)",
                    dialogTitle: "Select an alignment",
                    values: TextAlignment.allCases,
                    value: self.$textAlignment
                )

                CheckboxView(
                    text: "With Line limit",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isLineLimit
                )
            },
            integration: {
                TextLinkView(
                    theme: self.theme,
                    text: self.getText(from: self.content),
                    textHighlightRange: self.getTextHighlightRange(from: self.content),
                    intent: self.intent,
                    typography: self.typography,
                    variant: self.variant,
                    image: self.getImage(from: self.content),
                    alignment: self.contentAlignment,
                    action: {
                        self.showIngActionAlert = true
                    }
                )
                .multilineTextAlignment(self.textAlignment)
                .lineLimit(self.isLineLimit == .selected ? 2 : nil)
                .alert("TextLink tap", isPresented: $showIngActionAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        )
    }

    // MARK: - Getter

    private func getText(from content: TextLinkContent) -> String {
        switch content {
        case .text, .imageAndText:
            return Constants.text
        case .paragraph, .imageAndParagraph:
            return Constants.Long.text
        }
    }

    private func getTextHighlightRange(from content: TextLinkContent) -> NSRange? {
        switch content {
        case .text, .imageAndText:
            return nil
        case .paragraph, .imageAndParagraph:
            return Constants.Long.textHighlightRange
        }
    }

    private func getImage(from content: TextLinkContent) -> Image? {
        switch content {
        case .imageAndText, .imageAndParagraph:
            return Image("info")
        default:
            return nil
        }
    }
}

// MARK: - Preview

struct TextLinkComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TextLinkComponentView()
    }
}
