//
//  IconButtonViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkCore
import SwiftUI

final class IconButtonViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let scenarios = IconButtonScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations: [IconButtonConfigurationSnapshotTests] = try scenario.configuration(
                isSwiftUIComponent: true
            )

            for configuration in configurations {
                let view = IconButtonView(
                    theme: self.theme,
                    intent: configuration.intent,
                    variant: configuration.variant,
                    size: configuration.size,
                    shape: configuration.shape,
                    action: {}
                )
                    .disabled(configuration.state == .disabled)
                    .selected(configuration.state == .selected)
                    .image(configuration.image.rightValue, for: configuration.state)
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

private extension ButtonView {

    @ViewBuilder
    func content(_ configuration: ButtonConfigurationSnapshotTests) -> some View {
        let state = configuration.state
        switch configuration.content {
        case .title(let title):
            self.title(title, for: state)

        case .attributedTitle(let attributedTitle):
            self.attributedTitle(attributedTitle.rightValue, for: state)

        case .titleAndImage(let title, let image):
            self.title(title, for: state)
                .image(image.rightValue, for: state)

        case .attributedTitleAndImage(let attributedTitle, let image):
            self.attributedTitle(attributedTitle.rightValue, for: state)
                .image(image.rightValue, for: state)
        }
    }
}
