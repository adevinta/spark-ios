//
//  TagComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct TagComponentView: View {

    // MARK: - Properties

    let viewModel = TagComponentViewModel()

    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State private var uiKitViewHeight: CGFloat = .zero
    @State var intent: TagIntent = .main
    @State var variant: TagVariant = .filled
    @State var content: TagContent = .all

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
                    // **
                    // Theme
                    ThemeSelector(theme: self.$theme)

                    // **
                    // Intent
                    EnumSelector(
                        title: "Intent",
                        dialogTitle: "Select an Intent",
                        values: TagIntent.allCases,
                        value: self.$intent)
                    // **

                    // **
                    // Variant
                    EnumSelector(
                        title: "Variant",
                        dialogTitle: "Select a Variant",
                        values: TagVariant.allCases,
                        value: self.$variant)
                    // **

                    // **
                    // Content
                    EnumSelector(
                        title: "Content",
                        dialogTitle: "Select a Content",
                        values: TagContent.allCases,
                        value: self.$content)
                    // **
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                TagView(theme: self.theme )
                    .intent(self.intent)
                    .variant(self.variant)
                    .iconImage(self.content.shouldShowIcon ? Image(self.viewModel.imageNamed) : nil)
                    .text(self.content.shouldShowText ? self.viewModel.text : nil)
                    .accessibility(identifier: "MyTag1",
                                   label: "It's my first tag")

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Tag"))
    }
}

struct TagComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentView()
    }
}

// MARK: - Extension

private extension TagIntent {

    var name: String {
        switch self {
        case .alert:
            return "Alert"
        case .danger:
            return "Danger"
        case .info:
            return "Info"
        case .neutral:
            return "Neutral"
        case .main:
            return "Main"
        case .support:
            return "Support"
        case .success:
            return "Success"
        case .accent:
            return "Accent"
        case .basic:
            return "Basic"
        @unknown default:
            return "Please, add this unknow intent value"
        }
    }
}

private extension TagVariant {

    var name: String {
        switch self {
        case .filled:
            return "Filled"
        case .outlined:
            return "Outlined"
        case .tinted:
            return "Tinted"
        @unknown default:
            return "Please, add this unknow variant value"
        }
    }
}

private extension TagContent {

    var name: String {
        switch self {
        case .icon:
            return "Icon"
        case .text:
            return "Text"
        case .all:
            return "Icon & Text"
        }
    }
}
