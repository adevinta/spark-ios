//
//  ProgressBarConfigurationSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import XCTest

struct ProgressBarConfigurationSnapshotTests<Intent: CaseIterable> {

    // MARK: - Properties

    let scenario: ProgressBarScenarioSnapshotTests

    let intent: Intent
    let shape: ProgressBarShape
    let value: CGFloat
    var bottomValue: CGFloat { return self.value + 0.1 }
    let width: CGFloat = 100
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.shape)" + "Shape",
            "\(self.value)" + "Value"
        ].joined(separator: "-")
    }
}
