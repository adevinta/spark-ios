//
//  ProgressBarScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 18/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum ProgressBarScenarioSnapshotTests: String, CaseIterable {
    case test1Fake
    // TODO: add cases (check tag)

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration<Intent: CaseIterable>() -> [ProgressBarConfigurationSnapshotTests<Intent>] {
        // TODO: call scenarios func
        switch self {
        case .test1Fake:
            return self.test1Fake()
        }
    }

    // MARK: - Scenarios

    // TODO: add scenarios methods (check tag)

    private func test1Fake<Intent: CaseIterable>() -> [ProgressBarConfigurationSnapshotTests<Intent>] {
        let intentPossibilities = Intent.allCases

        return intentPossibilities.map { intent -> ProgressBarConfigurationSnapshotTests<Intent> in
            .init(
                scenario: self,
                intent: intent,
                shape: .square,
                value: 0.5,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }
}
