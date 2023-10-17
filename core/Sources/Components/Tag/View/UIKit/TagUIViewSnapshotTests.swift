//
//  TagUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

// TODO: rename SUT to Configuration

@testable import SparkCore

final class TagUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = TagScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {

                var view: TagUIView?
                switch (configuration.iconImage, configuration.text) {
                case (nil, nil):
                    XCTFail("Icon or text should be set")

                case (let iconImage?, nil):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        iconImage: iconImage.leftValue
                    )
                case (nil, let text?):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        text: text
                    )
                case let (iconImage?, text?):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        iconImage: iconImage.leftValue,
                        text: text
                    )
                }

                guard let view else {
                    return
                }

                view.translatesAutoresizingMaskIntoConstraints = false
                if let width = configuration.width {
                    view.widthAnchor.constraint(equalToConstant: width).isActive = true
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
