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
            MainView()
        }
    }
}
