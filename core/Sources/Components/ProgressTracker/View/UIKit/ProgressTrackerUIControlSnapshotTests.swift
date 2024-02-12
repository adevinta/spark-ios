//
//  ProgressTrackerUIControlSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import SparkCore

final class ProgressTrackerUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = ProgressTrackerScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {
                let view: ProgressTrackerUIControl

                if configuration.labels.isEmpty {
                    view = ProgressTrackerUIControl(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        size: configuration.size,
                        numberOfPages: 5,
                        orientation: configuration.orientation
                    )
                } else {
                    view = ProgressTrackerUIControl(
                        theme: self.theme,
                        intent: configuration.intent,
                        variant: configuration.variant,
                        size: configuration.size,
                        labels: configuration.labels,
                        orientation: configuration.orientation
                    )
                }

                switch configuration.contentType {
                case .icon: view.setPreferredIndicatorImage(UIImage(systemName: "lock.circle"))
                case .text:
                    view.showDefaultPageNumber = true
                case .empty:
                    view.showDefaultPageNumber = false
                }

                view.translatesAutoresizingMaskIntoConstraints = false
                view.sizeToFit()
                view.backgroundColor = .systemBackground

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
