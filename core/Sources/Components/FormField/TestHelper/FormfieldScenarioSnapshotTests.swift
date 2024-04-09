//
//  FormfieldScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 08.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

enum FormfieldScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5
    case test6
    case test7
    case test8

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration() -> [FormfieldConfigurationSnapshotTests] {
        switch self {
        case .test2:
            return self.test2()
        default:
            return []
        }
    }

    // MARK: - Scenarios

    /// Test 2
    ///
    /// Description: To test all feedback state for other components
    ///
    /// Content:
    ///  - feedbackState: all
    ///  - component: all
    ///  - label: short
    ///  - helperMessage: short
    ///  - isRequired: false,
    ///  - isEnabled: true
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test2() -> [FormfieldConfigurationSnapshotTests] {
        let feedbackStates = FormFieldFeedbackState.allCases
        let components = FormfieldComponentType.allCases

        return feedbackStates.flatMap { feedbackState in
            components.map { component in
                return .init(
                    scenario: self,
                    feedbackState: feedbackState,
                    component: component,
                    label: "Agreement",
                    helperMessage: "Your agreement is important.",
                    isRequired: false,
                    isEnabled: true,
                    modes: Constants.Modes.all,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }
}
