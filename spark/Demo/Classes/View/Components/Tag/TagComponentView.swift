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

    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    var theme: Theme {
        self.themePublisher.theme
    }
    @State private var isThemePresented = false

    let themes = ThemeCellModel.themes

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var intentSheetIsPresented = false
    @State var intent: TagIntent = .main

    @State private var variantSheetIsPresented = false
    @State var variant: TagVariant = .filled

    @State private var contentSheetIsPresented = false
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
                    HStack() {
                        Text("Theme: ").bold()
                        let selectedTheme = self.theme is SparkTheme ? themes.first : themes.last
                        Button(selectedTheme?.title ?? "") {
                            self.isThemePresented = true
                        }
                        .confirmationDialog("Select a theme",
                                            isPresented: self.$isThemePresented) {
                            ForEach(themes, id: \.self) { theme in
                                Button(theme.title) {
                                    themePublisher.theme = theme.theme
                                }
                            }
                        }
                        Spacer()
                    }                    // **

                    // **
                    // Intent
                    HStack() {
                        Text("Intent: ")
                            .bold()
                        Button("\(self.intent.name)") {
                            self.intentSheetIsPresented = true
                        }
                        .confirmationDialog("Select an intent", isPresented: self.$intentSheetIsPresented) {
                            ForEach(TagIntent.allCases, id: \.self) { intent in
                                Button("\(intent.name)") {
                                    self.intent = intent
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Variant
                    HStack() {
                        Text("Variant: ")
                            .bold()
                        Button("\(self.variant.name)") {
                            self.variantSheetIsPresented = true
                        }
                        .confirmationDialog("Select an variant", isPresented: self.$variantSheetIsPresented) {
                            ForEach(TagVariant.allCases, id: \.self) { variant in
                                Button("\(variant.name)") {
                                    self.variant = variant
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Content
                    HStack() {
                        Text("Content: ")
                            .bold()
                        Button("\(self.content.name)") {
                            self.contentSheetIsPresented = true
                        }
                        .confirmationDialog("Select an content", isPresented: self.$contentSheetIsPresented) {
                            ForEach(TagContent.allCases, id: \.self) { content in
                                Button("\(content.name)") {
                                    self.content = content
                                }
                            }
                        }
                    }
                    // **
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                TagView(theme: SparkTheme.shared)
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
