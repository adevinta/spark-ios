//
//  SparkDemoTabbarController.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import Spark
import SparkCore
import Combine

final class SparkTabbarController: UITabBarController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []

    /// First Tab
    private lazy var themeViewController: UIViewController = {
        let viewController = UIHostingController(rootView: ThemeView())
        viewController.tabBarItem = UITabBarItem(title: "Theme", image: UIImage(systemName: "paintpalette"), tag: 0)
        return viewController
    }()

    /// Second Tab
    private lazy var componentVersionViewController: UIViewController = {
        var layout = ComponentVersionViewController.makeLayout()
        let viewController = UINavigationController(rootViewController: ComponentVersionViewController(collectionViewLayout: layout))
        viewController.tabBarItem = UITabBarItem(title: "Components", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        return viewController
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadSparkConfiguration()
        self.setUpControllers()
        self.addObservers()
        self.addPublishers()
    }

    private func loadSparkConfiguration() {
        SparkConfiguration.load()
    }

    private func setUpControllers() {
        viewControllers = [
            self.themeViewController,
            self.componentVersionViewController
        ]
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(forName: UIDevice.deviceDidShakeNotification, object: nil, queue: .main) { _ in
            self.presentThemeSwitchViewController()
        }
    }

    private func addPublishers() {
        self.themePublisher
            .$theme
            .eraseToAnyPublisher()
            .sink { theme in
            self.tabBar.tintColor = theme.colors.main.main.uiColor
        }
        .store(in: &cancellables)
    }
}

// MARK: - Navigation
extension SparkTabbarController {

    private func presentThemeSwitchViewController() {
        let themeSwitchViewController = UIHostingController(
            rootView: ThemeSwitchView(
                dismissAction: { self.presentedViewController?.dismiss(animated: false) }
            )
        )
        themeSwitchViewController.modalPresentationStyle = .overCurrentContext
        themeSwitchViewController.modalTransitionStyle = .crossDissolve
        themeSwitchViewController.view.backgroundColor = .clear
        self.present(themeSwitchViewController, animated: true)
    }
}
