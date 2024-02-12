//
//  ProgressTrackerConfigurationSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
@testable import SparkCore

struct ProgressTrackerConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: ProgressTrackerScenarioSnapshotTests

    let intent: ProgressTrackerIntent
    let variant: ProgressTrackerVariant
    let state: ProgressTrackerState
    let contentType: ProgressTrackerContentType
    let size: ProgressTrackerSize
    let orientation: ProgressTrackerOrientation

    let labels: [String]
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.variant)",
            "\(self.variant)",
            "\(self.contentType)",
            "\(self.size)",
            "\(self.orientation)",
            labels.isEmpty ? "noLabels" : "labels",
            self.state.isDisabled ? "disabled" : "enabled",
            self.state.isSelected ? "selected" : "notSelected"
        ].joined(separator: "-")
    }

}
