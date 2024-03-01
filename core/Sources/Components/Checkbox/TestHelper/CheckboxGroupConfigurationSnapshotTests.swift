//
//  CheckboxGroupConfigurationSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 16.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

@testable import SparkCore

struct CheckboxGroupConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: CheckboxGroupScenarioSnapshotTests
    let intent: CheckboxIntent
    let alignment: CheckboxAlignment
    let axis: CheckboxGroupLayout
    let items: [any CheckboxGroupItemProtocol]
    let image: UIImage
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.alignment)",
            "\(self.axis)"
        ].joined(separator: "-")
    }
}
