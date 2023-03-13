//
//  SparkDemoApp.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore
import Spark

@main
struct SparkDemoApp: App {

    // MARK: - Initialization

    init() {
        // Configuration
        SparkConfiguration.load()

        // Set themes
        CurrentTheme.part = SparkCurrentTheme.theme
        CurrentTheme.pro = SparkCurrentTheme.theme
    }

    // MARK: - Scene

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
