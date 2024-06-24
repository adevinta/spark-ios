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
    case test1
    case test2
    case test3

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration<Intent: CaseIterable>() throws -> [ProgressBarConfigurationSnapshotTests<Intent>] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return try self.test2()
        case .test3:
            return try self.test3()
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intents: all
    ///  - value : 0.5
    ///  - shape: default
    ///  - mode : all
    ///  - size : default
    private func test1<Intent: CaseIterable>() -> [ProgressBarConfigurationSnapshotTests<Intent>] {
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

    /// Test 2
    ///
    /// Description: To test all shapes for all a11y sizes
    ///
    /// Content:
    /// - intent: main
    /// - value : 0.5
    /// - shapes: all
    /// - mode : default
    /// - sizes : all
    private func test2<Intent: CaseIterable>() throws -> [ProgressBarConfigurationSnapshotTests<Intent>] {
        let shapesPossibilities = ProgressBarShape.allCases

        return try shapesPossibilities.map { shape -> ProgressBarConfigurationSnapshotTests<Intent> in
            .init(
                scenario: self,
                intent: try Intent.firstCase,
                shape: shape,
                value: 0.5,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test some values for all a11y sizes
    ///
    /// Content:
    /// - intent: basic
    /// - value : 0 + 0.3 + 0.75 + 1
    /// - shape: default
    /// - mode : default
    /// - sizes : all
    private func test3<Intent: CaseIterable>() throws -> [ProgressBarConfigurationSnapshotTests<Intent>] {
        let valuesPossibilities = [0, 0.3, 0.75, 1]

        return try valuesPossibilities.map { value -> ProgressBarConfigurationSnapshotTests<Intent> in
            .init(
                scenario: self,
                intent: try Intent.firstCase,
                shape: .square,
                value: value,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        }
    }
}

// MARK: - Extension

private extension CaseIterable {

    static var firstCase: Self {
        get throws {
            guard let firstCase = Self.allCases.first else {
                throw ProgressBarScenarioError.noIntent
            }

            return firstCase
        }
    }
}

// MARK: - Error

private enum ProgressBarScenarioError: Error {
    case noIntent
}
