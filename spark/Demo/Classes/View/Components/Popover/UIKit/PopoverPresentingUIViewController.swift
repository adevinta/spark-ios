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

    private let theme = SparkTheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        let buttons: [UIView] = PopoverIntent.allCases.enumerated().map { index, intent in
            let popoverColors = intent.getColors(theme: self.theme)
            let button = UIButton(configuration: .filled())
            button.setTitle(intent.name, for: .normal)
            button.setTitleColor(popoverColors.foreground.uiColor, for: .normal)
            button.tintColor = popoverColors.background.uiColor
            button.addAction(.init(handler: { [weak self] _ in
                self?.showPopover(sourceView: button, intent: intent, withArrow: index % 2 == 0)
            }), for: .touchUpInside)
            return button
        }

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12

        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    private func showPopover(sourceView: UIView, intent: PopoverIntent, withArrow showArrow: Bool) {
        if let presentedViewController {
            presentedViewController.dismiss(animated: true)
        } else {
            let theme = SparkTheme()
            let popoverViewController = PopoverViewController(contentViewController: PopoverContentDemoViewController(theme: theme, intent: intent), theme: theme, intent: intent, showArrow: showArrow)
            self.presentPopover(popoverViewController, sourceView: sourceView)
        }
    }
}

// MARK: - Builder
extension PopoverPresentingUIViewController {

    static func build() -> PopoverPresentingUIViewController {
        return PopoverPresentingUIViewController()
    }
}
