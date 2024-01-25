//
//  TextFieldComponentView.swift
//  Spark
//
//  Created by Quentin.richard on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

private struct TextFieldPreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "Test \(value)"
    }
}

struct TextFieldComponentView: View {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    @State var isThemePresented = false

    let themes = ThemeCellModel.themes

    @State var intent: BadgeIntentType = .danger
    @State var isIntentPresented = false

    @State var size: BadgeSize = .medium
    @State var isSizePresented = false

    @State var value: Int? = 99

    @State var format: BadgeFormat = .default
    @State var isFormatPresented = false

    @State var isBorderVisible: CheckboxSelectionState = .unselected

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)

            VStack(alignment: .leading, spacing: 8) {
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
                HStack() {
                    Text("Intent: ").bold()
                    Button(self.intent.name) {
                        self.isIntentPresented = true
                    }
                    .confirmationDialog("Select an intent", isPresented: self.$isIntentPresented) {
                        ForEach(BadgeIntentType.allCases, id: \.self) { intent in
                            Button(intent.name) {
                                self.intent = intent
                            }
                        }
                    }
                }
                HStack() {
                    Text("Badge Size: ").bold()
                    Button(self.size.name) {
                        self.isSizePresented = true
                    }
                    .confirmationDialog("Select a size", isPresented: self.$isSizePresented) {
                        ForEach(BadgeSize.allCases, id: \.self) { size in
                            Button(size.name) {
                                self.size = size
                            }
                        }
                    }
                }
                HStack() {
                    Text("Format ").bold()
                    Button(self.format.name) {
                        self.isFormatPresented = true
                    }
                    .confirmationDialog("Select a format", isPresented: self.$isFormatPresented) {
                        ForEach(BadgeFormat.allNames, id: \.self) { name in
                            Button(name) {
                                self.format = BadgeFormat.from(name: name)
                            }
                        }
                    }
                }
                HStack() {
                    Text("Value ").bold()
                    TextField("Value", value: self.$value, formatter: NumberFormatter())
                }

                CheckboxView(
                    text: "With Border",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    selectionState: self.$isBorderVisible
                )
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

            BadgeView(theme: self.theme, intent: self.intent, value: self.value)
                .size(self.size)
                .format(self.format)
                .borderVisible(self.isBorderVisible == .selected)

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Badge"))
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}

private extension BadgeFormat {
    static var allNames: [String] = [Names.default, Names.custom, Names.overflowCounter]

    static func from(name: String) -> BadgeFormat {
        switch name {
        case Names.custom: return .custom(formatter: BadgePreviewFormatter())
        case Names.overflowCounter: return .overflowCounter(maxValue: 99)
        default: return .default
        }
    }
 }
