//
//  TagComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

struct TagComponentView: View {

    // MARK: - Properties

    private let viewModel = TagComponentViewModel()

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TagIntent = .main
    @State private var variant: TagVariant = .filled
    @State private var content: TagContent = .iconAndText

    // MARK: - View

    var body: some View {
        Component(
            name: "Tag",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: TagIntent.allCases,
                    value: self.$intent)

                EnumSelector(
                    title: "Variant",
                    dialogTitle: "Select a Variant",
                    values: TagVariant.allCases,
                    value: self.$variant)

                EnumSelector(
                    title: "Content",
                    dialogTitle: "Select a Content",
                    values: TagContent.allCases,
                    value: self.$content)
            },
            integration: {
                TagView(
                    theme: self.theme,
                    intent: self.intent,
                    variant: self.variant
                )
                .iconImage(self.content.shouldShowIcon ? Image(self.viewModel.imageNamed) : nil)
                .text(self.content, viewModel: self.viewModel)
//                .accessibility(identifier: "MyTag1",
//                               label: "It's my first tag")
            }
        )
    }
}

// MARK: - TagView Extension

extension TagView {

    func text(_ content: TagContent, viewModel: TagComponentViewModel) -> Self {
        if content.shouldShowAttributedText {
            return self.attributedText(viewModel.attributedText(content.text))
        } else {
            return self.text(content.shouldShowText ? content.text : nil)
        }
    }
}

// MARK: - Preview

struct TagComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentView()
    }
}
