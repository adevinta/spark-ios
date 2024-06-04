//
//  ButtonUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon
import SparkTheme

final class ButtonUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = ButtonScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [ButtonConfigurationSnapshotTests] = try scenario.configuration(
                isSwiftUIComponent: false
            )
            for configuration in configurations {

                let view: ButtonUIView = .init(
                    theme: self.theme,
                    intent: configuration.intent,
                    variant: configuration.variant,
                    size: configuration.size,
                    shape: configuration.shape,
                    alignment: configuration.alignment
                )
                view.isHighlighted = configuration.state == .highlighted
                view.isEnabled = configuration.state != .disabled
                view.isSelected = configuration.state == .selected

                let state = configuration.state
                switch configuration.content {
                case .title(let title):
                    view.setTitle(title, for: state)

                case .attributedTitle(let attributedTitle):
                    view.setAttributedTitle(attributedTitle.leftValue, for: state)

                case .titleAndImage(let title, let image):
                    view.setTitle(title, for: state)
                    view.setImage(image.leftValue, for: state)

                case .attributedTitleAndImage(let attributedTitle, let image):
                    view.setAttributedTitle(attributedTitle.leftValue, for: state)
                    view.setImage(image.leftValue, for: state)
                }

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
