//
//  SpinnerComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct SpinnerComponent: View {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    @State private var isThemePresented = false

    var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme()),
        .init(title: "Purple", theme: PurpleTheme())
    ]

    @State var intent: SpinnerIntent = .main
    @State var isIntentPresented = false
    @State var spinnerSize: SpinnerSize = .medium
    @State var isSizesPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)
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
                    ForEach(SpinnerIntent.allCases, id: \.self) { intent in
                        Button(intent.name) {
                            self.intent = intent
                        }
                    }
                }
            }
            HStack() {
                Text("Spinner Size: ").bold()
                Button(self.spinnerSize.name) {
                    self.isSizesPresented = true
                }
                .confirmationDialog("Select a size", isPresented: self.$isSizesPresented) {
                    ForEach(SpinnerSize.allCases, id: \.self) { size in
                        Button(size.name) {
                            self.spinnerSize = size
                        }
                    }
                }
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

            SpinnerView(theme: self.theme,
                        intent: self.intent,
                        spinnerSize: self.spinnerSize
            )

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Spinner"))
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}
