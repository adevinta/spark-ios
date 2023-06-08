//
//  MainView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct MainView: View {

    // MARK: - Properties

    private let viewModel = BorderViewModel()

    @ObservedObject var colorSchemeManager = ColorSchemeManager.shared

    @Environment(\.colorScheme) var systemColorScheme: ColorScheme

    var colorScheme: ColorScheme {
        if let overriddenColorScheme = colorSchemeManager.colorScheme {
            return overriddenColorScheme
        } else {
            return self.systemColorScheme
        }
    }

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View

    var body: some View {
        ZStack {
            contentView

            ThemeSwitchView()
        }
        .colorScheme(self.colorScheme)
    }

    var contentView: some View {
        NavigationView {
            TabView {
                ThemeView()
                    .tabItem {
                        Image(systemName: "paintpalette")
                        Text("Theme")
                    }

                ComponentsView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Components")
                    }
            }
        }
        .accentColor(self.theme.colors.primary.primary.color)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

class ColorSchemeManager: ObservableObject {
    static let shared = ColorSchemeManager()
    private init() {}

    @Published var colorScheme: ColorScheme?
}
