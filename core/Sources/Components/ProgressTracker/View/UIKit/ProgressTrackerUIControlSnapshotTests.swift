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
                    for i in 0..<5 {
                        view.setIndicatorLabel("A\(i+1)", forIndex: i)
                    }
                case .empty:
                    view.showDefaultPageNumber = false
                }

                switch configuration.state {
                case .disabled: view.isEnabled = false
                case .selected: view.currentPageIndex = 1
                case .pressed: view.indicatorViews[1].isHighlighted = true
                default: break
                }

                view.backgroundColor = .systemBackground
                view.translatesAutoresizingMaskIntoConstraints = false

                if let frame = configuration.frame {
                    let containerView = UIView(frame: frame)
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    containerView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
                    containerView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
                    containerView.addSubviewSizedEqually(view)

                    self.assertSnapshot(
                        matching: containerView,
                        modes: configuration.modes,
                        sizes: configuration.sizes,
                        testName: configuration.testName()
                    )
                } else {
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
}
