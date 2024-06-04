//
//  RatingInputViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 08.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheme

final class RatingInputViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    private var backingRating: CGFloat = 0

    private lazy var rating: Binding<CGFloat> = {
        return Binding<CGFloat>(
            get: { return self.backingRating },
            set: { newValue, transaction in
                self.backingRating = newValue
            }
        )
    }()

    func test() {
        let scenarios = RatingInputScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: true)
            for configuration in configurations {
                self.backingRating = configuration.rating
                let view = RatingInputView(
                    theme: self.theme,
                    intent: .main,
                    rating: self.rating)
                    .highlighted(configuration.state == .pressed)
                    .disabled(configuration.state == .disabled)

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
