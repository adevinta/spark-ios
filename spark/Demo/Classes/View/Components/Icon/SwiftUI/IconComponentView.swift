//
//  IconComponentView.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct IconComponentView: View {

    // MARK: - Properties

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    @State private var isThemePresented = false

    var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme()),
        .init(title: "Purple", theme: PurpleTheme())
    ]

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var sizeSheetIsPresented = false
    @State var size: IconSize = .medium

    @State private var intentSheetIsPresented = false
    @State var intent: IconIntent = .main

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
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
                    }

                    // Intent
                    HStack() {
                        Text("Intent: ")
                            .bold()
                        Button("\(self.intent.name)") {
                            self.intentSheetIsPresented = true
                        }
                        .confirmationDialog(
                            "Select an intent",
                            isPresented: self.$intentSheetIsPresented) {
                                ForEach(IconIntent.allCases, id: \.self) { intent in
                                    Button("\(intent.name)") {
                                        self.intent = intent
                                    }
                                }
                            }
                    }

                    // Size
                    HStack() {
                        Text("Size: ")
                            .bold()
                        Button("\(self.size.name)") {
                            self.sizeSheetIsPresented = true
                        }
                        .confirmationDialog(
                            "Select a size",
                            isPresented: self.$sizeSheetIsPresented) {
                                ForEach(IconSize.allCases, id: \.self) { size in
                                    Button("\(size.name)") {
                                        self.size = size
                                    }
                                }
                            }
                    }
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()


                IconView(
                    theme: SparkTheme.shared,
                    intent: self.intent,
                    size: self.size,
                    iconImage: Image("alert")
                )

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Icon"))
    }
}

struct IconComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconComponentView()
    }
}
