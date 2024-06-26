//
//  PopoverPresentingUIViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 26/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class PopoverPresentingUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let button = UIButton(configuration: .filled())
        button.setTitle("Show Popover", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        button.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }
            if let presentedViewController {
                presentedViewController.dismiss(animated: true)
            } else {
                let theme = SparkTheme()
                let intent = PopoverIntent.main
                let popoverViewController = PopoverViewController(contentViewController: PopoverContentDemoViewController(theme: theme, intent: intent), theme: theme, intent: intent, showArrow: true)
                self.presentPopover(popoverViewController, sourceView: button)
            }
        }), for: .touchUpInside)
    }
}

// MARK: - Builder
extension PopoverPresentingUIViewController {

    static func build() -> PopoverPresentingUIViewController {
        return PopoverPresentingUIViewController()
    }
}
