//
//  RatingDisplayUIViewSnapshotTests.swift
//  Spark
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

final class RatingDisplayUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = RatingDisplayScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {
                let view = RatingDisplayUIView(
                    theme: self.theme,
                    intent: .main,
                    count: configuration.count,
                    size: configuration.size,
                    rating: configuration.rating
                )

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
