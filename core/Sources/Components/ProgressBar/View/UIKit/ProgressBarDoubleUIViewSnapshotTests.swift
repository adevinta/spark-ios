//
//  ProgressBarDoubleUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore

final class ProgressBarDoubleUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = ProgressBarScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [ProgressBarConfigurationSnapshotTests<ProgressBarDoubleIntent>] = scenario.configuration()
            for configuration in configurations {
                let view: ProgressBarDoubleUIView = .init(
                    theme: self.theme,
                    intent: configuration.intent,
                    shape: configuration.shape
                )
                view.topValue = configuration.value
                view.bottomValue = configuration.bottomValue

                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: configuration.width).isActive = true

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}
