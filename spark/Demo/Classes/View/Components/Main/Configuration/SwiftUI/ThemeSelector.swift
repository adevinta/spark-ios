//
//  ThemeSelector.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 13.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI

struct ThemeSelector: View {
    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    var theme: Theme {
        self.themePublisher.theme
    }
    @State private var isThemePresented = false

    let themes = ThemeCellModel.themes
    @Binding var currentTheme: any Theme

    init(theme: Binding<any Theme>) {
        self._currentTheme = theme
    }

    var body: some View {
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
                        self.currentTheme = theme.theme
                    }
                }
            }
            Spacer()
        }
    }
}

