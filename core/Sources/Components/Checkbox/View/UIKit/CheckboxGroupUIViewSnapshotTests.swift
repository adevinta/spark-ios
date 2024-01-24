//
//  CheckboxGroupUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 16.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

final class CheckboxGroupUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = CheckboxGroupScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for (index, configuration) in configurations.enumerated() {

                let view = CheckboxGroupUIView(
                    checkedImage: configuration.image,
                    items: configuration.items,
                    layout: configuration.axis,
                    alignment: configuration.alignment,
                    theme: self.theme,
                    intent: configuration.intent,
                    accessibilityIdentifierPrefix: "\(index)"
                )
                view.translatesAutoresizingMaskIntoConstraints = false


                let containerView = UIView()
                containerView.backgroundColor = UIColor.systemBackground
                containerView.translatesAutoresizingMaskIntoConstraints = false
                containerView.addSubview(view)

                NSLayoutConstraint.stickEdges(from: view, to: containerView)

                if configuration.axis == .vertical {
                    containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
                } else {
                    containerView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width).isActive = true
                }

                self.assertSnapshot(
                    matching: containerView,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    record: true,
                    testName: configuration.testName()
                )
            }
        }
    }
}
