//
//  ProgressBarUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheme

final class ProgressBarUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = ProgressBarScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [ProgressBarConfigurationSnapshotTests<ProgressBarIntent>] = try scenario.configuration()
            for configuration in configurations {
                let view: ProgressBarUIView = .init(
                    theme: self.theme,
                    intent: configuration.intent,
                    shape: configuration.shape
                )
                view.value = configuration.value

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
