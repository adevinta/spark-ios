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
            let suts = scenario.sut(isSwiftUIComponent: true)
            for sut in suts {
                let view = TagView(theme: self.theme)
                    .intent(sut.intent)
                    .variant(sut.variant)
                    .iconImage(sut.iconImage?.rightValue)
                    .text(sut.text)
                    .frame(width: sut.width)
                    .fixedSize()

                self.assertSnapshot(
                    matching: view,
                    modes: sut.modes,
                    sizes: sut.sizes,
                    testName: sut.testName()
                )
            }
        }
    }
}
