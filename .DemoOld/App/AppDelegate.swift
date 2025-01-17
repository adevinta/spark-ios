//
//  SparkDelegate.swift
//  SparkDemo
//
//  Created by alican.aycil on 09.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
@_exported import SparkCore
@_exported import SparkCoreTesting

/// Appdelegate was added for starting app with a viewcontroller. So It help us to integrate UIkit components to UIViewController class diretly. SwiftUI components are working on UIHostingController class more stablize than UIkit components that was integrated with a UIViewRepresentable class.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
