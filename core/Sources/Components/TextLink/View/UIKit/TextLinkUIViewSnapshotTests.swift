//
//  TextLinkUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore

final class TextLinkUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = TextLinkScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [TextLinkConfigurationSnapshotTests] = scenario.configuration(
                isSwiftUIComponent: false
            )
            for configuration in configurations {

                let view: TextLinkUIView = .init(
                    theme: self.theme,
                    text: configuration.type.text,
                    textColorToken: configuration.color.colorToken(from: self.theme),
                    textHighlightRange: configuration.type.textHighlightRange,
                    typography: configuration.size.typography,
                    variant: configuration.variant,
                    image: configuration.image?.leftValue,
                    alignment: configuration.alignment
                )
                view.textAlignment = .left
                view.numberOfLines = 0

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
