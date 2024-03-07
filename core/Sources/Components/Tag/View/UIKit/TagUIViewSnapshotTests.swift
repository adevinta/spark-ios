//
//  TagUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

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

                var view: TagUIView
                switch configuration.content {
                case .text(let text), .longText(let text):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        text: text
                    )

                case .attributedText(let attributedText):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        attributedText: attributedText.leftValue
                    )

                case .icon(let image):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        iconImage: image.leftValue
                    )

                case let .iconAndText(image, text), let .iconAndLongText(image, text):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        iconImage: image.leftValue,
                        text: text
                    )

                case let .iconAndAttributedText(image, attributedText):
                    view = TagUIView(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        iconImage: image.leftValue,
                        attributedText: attributedText.leftValue
                    )
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
