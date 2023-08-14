//
//  SparkDemoTabbarController.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// swiftlint:disable all

import UIKit
import SwiftUI
import Spark
import SparkCore
import Combine

final class SparkDemoTabbarController: UITabBarController {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    private var cancellables: Set<AnyCancellable> = []

    private lazy var themeViewController: UIViewController = {
        let viewController = UIHostingController(rootView: ThemeView())
        viewController.tabBarItem = UITabBarItem(title: "Theme", image: UIImage(systemName: "paintpalette"), tag: 0)
        return viewController
    }()

    private lazy var componentsViewController: UIViewController = {
        let viewController = UIHostingController(rootView: ComponentsView())
        viewController.tabBarItem = UITabBarItem(title: "Components", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        return viewController
    }()

    private lazy var uiComponentsViewController: UIViewController = {
        var layout = ComponentsViewController.makeLayout()
        let viewController = UINavigationController(rootViewController: ComponentsViewController(collectionViewLayout: layout))
        viewController.tabBarItem = UITabBarItem(title: "UIComponents", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        return viewController
    }()

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
            themeViewController, componentsViewController, uiComponentsViewController
        ]
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(forName: UIDevice.deviceDidShakeNotification, object: nil, queue: .main) { _ in
            self.presentThemeSwitchViewController()
        }
    }

    private func addPublishers() {
        self.themePublisher.$theme.eraseToAnyPublisher().sink { theme in
            self.tabBar.tintColor = theme.colors.main.main.uiColor
        }
        .store(in: &cancellables)
    }

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
