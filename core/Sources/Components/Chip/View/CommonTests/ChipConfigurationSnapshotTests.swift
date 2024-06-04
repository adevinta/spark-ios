//
//  ChipConfigurationSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by michael.zimmermann on 26.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct ChipConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: ChipScenarioSnapshotTests

    let intent: ChipIntent
    let variant: ChipVariant
    let icon: ImageEither?
    let text: String?
    let badge: ViewEither?
    let state: ChipState

    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.variant)",
            self.icon != nil ? "withImage" : "withoutImage",
            self.text != nil ? "withText" : "withoutText",
            self.badge != nil ? "withBadge" : "withoutBadge",
            self.state.isDisabled ? "disabled" : "enabled",
            self.state.isSelected ? "selected" : "notSelected"
        ].joined(separator: "-")
    }
}
