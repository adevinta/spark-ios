//
//  TextLinkViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore
import SparkTheme
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SwiftUI

final class TextLinkViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = TextLinkScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [TextLinkConfigurationSnapshotTests] = scenario.configuration(
                isSwiftUIComponent: true
            )

            for configuration in configurations {
                let view = TextLinkView(
                    theme: self.theme,
                    text: configuration.type.text,
                    textHighlightRange: configuration.type.textHighlightRange,
                    intent: configuration.intent,
                    typography: configuration.size.typography,
                    variant: configuration.variant,
                    image: configuration.image?.rightValue,
                    alignment: configuration.alignment,
                    action: {}
                )
                    .fixedSize()

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
