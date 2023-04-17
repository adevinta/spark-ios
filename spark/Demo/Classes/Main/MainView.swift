//
//  MainView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark

struct MainView: View {

    // MARK: - Properties

    private let viewModel = BorderViewModel()

    // MARK: - View

    var body: some View {
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
        .accentColor(SparkTheme.shared.colors.primary.primary.color)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
