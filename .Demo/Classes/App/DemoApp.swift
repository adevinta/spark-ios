//
//  DemoApp.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
@_exported import SparkCore
@_exported import SparkCoreTesting

@main
struct DemoApp: App {

    // MARK: - Initialization

    init() {
        // Configuration
        SparkConfiguration.load()
    }

    // MARK: - View

    var body: some Scene {
        WindowGroup {
            // TODO: put Main in public with parameter: the themes.
            // TODO: with that, we can use the app in SparkKit with the LBC theme
            MainView()
        }
    }
}
