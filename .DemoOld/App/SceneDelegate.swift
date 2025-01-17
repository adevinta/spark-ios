//
//  SceneDelegate.swift
//  SparkDemo
//
//  Created by alican.aycil on 09.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import SparkSnackbar
import SparkButton
import SparkTheming

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        SparkConfiguration.load()
        window.rootViewController = SparkTabbarController()
        self.window = window
        window.makeKeyAndVisible()

        ConsoleView.shared.show()
    }
}
