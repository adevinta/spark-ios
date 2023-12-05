//
//  RatingInputUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

final class RatingInputUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = RatingInputScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {
                let view = RatingInputUIView(
                    theme: self.theme,
                    intent: .main,
                    rating: configuration.rating
                )

                if configuration.state == .disabled {
                    view.isEnabled = false
                } else if configuration.state == .pressed {
                    view.isHighlighted = true
                }

                view.backgroundColor = UIColor.lightGray

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
