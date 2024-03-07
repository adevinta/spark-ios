//
//  TagViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import SparkCore

final class TagViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = TagScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: true)
            for configuration in configurations {
                let view = TagView(
                    theme: self.theme,
                    intent: configuration.intent,
                    variant: configuration.variant
                )
                    .content(configuration)
                    .frame(width: configuration.width)
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

// MARK: - Extension

private extension TagView {

    @ViewBuilder
    func content(_ configuration: TagConfigurationSnapshotTests) -> some View {
        switch configuration.content {
        case .text(let text), .longText(let text):
            self.text(text)

        case .attributedText(let attributedText):
            self.attributedText(attributedText.rightValue)

        case .icon(let image):
            self.iconImage(image.rightValue)

        case let .iconAndText(image, text), let .iconAndLongText(image, text):
            self.iconImage(image.rightValue)
                .text(text)

        case let .iconAndAttributedText(image, attributedText):
            self.iconImage(image.rightValue)
                .attributedText(attributedText.rightValue)
        }
    }
}

