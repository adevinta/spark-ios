//
//  SparkCoreDemoApp.swift
//  SparkCoreDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

@main
struct SparkCoreDemoApp: App {

    init() {
        // Configuration
        SparkConfiguration.load()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
