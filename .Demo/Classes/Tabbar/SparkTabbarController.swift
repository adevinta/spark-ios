//
//  SparkDemoTabbarController.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import SparkCore
import Combine

public final class SparkTabbarController: UITabBarController {

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
        viewController.tabBarItem = UITabBarItem(title: "Components", image: UIImage(systemName: "apple.logo"), tag: 0)
        return viewController
    }()

    /// Third Tab
    private lazy var uiKitViewController: UIViewController = {
        let viewController = UIHostingController(rootView: NewComponentsView(isUIKit: true))
        viewController.tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "u.circle"), tag: 0)
        return viewController
    }()

    /// Fourth Tab
    private lazy var swiftUIViewController: UIViewController = {
        let viewController = UIHostingController(rootView: NewComponentsView(isUIKit: false))
        viewController.tabBarItem = UITabBarItem(title: "SwiftUI", image: UIImage(systemName: "s.circle"), tag: 0)
        return viewController
    }()

    // MARK: - ViewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.loadSparkConfiguration()
        self.setUpControllers()
        self.addPublishers()
    }

    private func loadSparkConfiguration() {
        SparkConfiguration.load()
    }

    private func setUpControllers() {
        viewControllers = [
            self.themeViewController,
            self.componentVersionViewController,
            self.uiKitViewController,
            self.swiftUIViewController
        ]
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
