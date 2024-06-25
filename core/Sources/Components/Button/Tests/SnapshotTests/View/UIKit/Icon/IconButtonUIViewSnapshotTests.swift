//
//  IconButtonUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore

final class IconButtonUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = IconButtonScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [IconButtonConfigurationSnapshotTests] = try scenario.configuration(
                isSwiftUIComponent: false
            )
            for configuration in configurations {

                let view: IconButtonUIView = .init(
                    theme: self.theme,
                    intent: configuration.intent,
                    variant: configuration.variant,
                    size: configuration.size,
                    shape: configuration.shape
                )
                view.isHighlighted = configuration.state == .highlighted
                view.isEnabled = configuration.state != .disabled
                view.isSelected = configuration.state == .selected

                view.setImage(configuration.image.leftValue, for: configuration.state)

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
