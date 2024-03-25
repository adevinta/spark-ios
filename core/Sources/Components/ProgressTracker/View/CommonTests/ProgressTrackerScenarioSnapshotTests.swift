//
//  ProgressTrackerScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

@testable import SparkCore

enum ProgressTrackerContentType {
    case icon
    case text
    case empty
}

enum ProgressTrackerScenarioSnapshotTests: String, CaseIterable {
    case test1 // All intents
    case test2 // All variants and states
    case test3 // Test content resilience
    case test4 // Test component sizes
    case test5 // Test all a11y sizes
    case test6 // Test orientation with different label sizes

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1(isSwiftUIComponent: isSwiftUIComponent)
        case .test2:
            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
        case .test3:
            return self.test3(isSwiftUIComponent: isSwiftUIComponent)
        case .test4:
            return self.test4(isSwiftUIComponent: isSwiftUIComponent)
        case .test5:
            return self.test5(isSwiftUIComponent: isSwiftUIComponent)
        case .test6:
            return self.test6(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intents: all
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: icon
    ///  - size: medium
    ///  - orientation: horizontal
    ///  - label: none
    ///  - mode: all
    ///  - a11y size: medium
    private func test1(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {
        let intents = ProgressTrackerIntent.allCases

        return intents.map {
            .init(
                scenario: self,
                intent: $0,
                variant: .outlined,
                state: .normal,
                contentType: .icon,
                size: .medium, 
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all variants & states
    ///
    /// Content:
    ///  - intents: basic
    ///  - variant: all
    ///  - state: all // except selected, since this will also be tested with normal
    ///  - content: icon
    ///  - size: medium
    ///  - orientation: horizontal
    ///  - label: none
    ///  - mode: light
    ///  - a11y size: medium
    private func test2(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {
        let variants = ProgressTrackerVariant.allCases
        let states: [ProgressTrackerState] = [.normal, .pressed, .disabled]

        let allCases: [(variant: ProgressTrackerVariant, state: ProgressTrackerState)] = variants.flatMap{ variant in
            return states.map{ state in
                return (variant, state)
            }
        }

        return allCases.map {
            .init(
                scenario: self,
                intent: .basic,
                variant: $0.variant,
                state: $0.state,
                contentType: .icon,
                size: .medium,
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test content resilience
    ///
    /// Content:
    ///  - intents: basic
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: char/none
    ///  - size: medium
    ///  - orientation: horizontal
    ///  - label: none
    ///  - mode: light
    ///  - a11y size: medium
    private func test3(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {

        let allContents: [ProgressTrackerContentType] = [.empty, .text]

        return allContents.map {
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: $0,
                size: .medium,
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 4
    ///
    /// Description: To test component sizes
    ///
    /// Content:
    ///  - intents: basic
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: text
    ///  - size: all
    ///  - orientation: horizontal
    ///  - label: none
    ///  - mode: light
    ///  - a11y size: medium
    private func test4(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {

        return ProgressTrackerSize.allCases.map {
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: .text,
                size: $0,
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 5
    ///
    /// Description: To test all a11y sizes
    ///
    /// Content:
    ///  - intents: basic
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: text
    ///  - size: medium
    ///  - orientation: horizontal
    ///  - label: none
    ///  - mode: light
    ///  - a11y size: all
    private func test5(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {

        return [
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: .text,
                size: .medium,
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        ]
    }

    /// Test 6
    ///
    /// Description: test orientations with different labels sizes
    ///
    /// Content:
    ///  - intents: basic
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: text
    ///  - size: medium
    ///  - orientation: all
    ///  - label: with long label / none
    ///  - mode: light
    ///  - a11y size: medium
    private func test6(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {

        let longLabels = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "Lorem ipsum dolor sit amet",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
            "Ut enim ad minim veniam",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit"]

        return [
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: .text,
                size: .medium,
                orientation: .vertical,
                labels: [],
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            ),
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: .text,
                size: .medium,
                orientation: .horizontal,
                labels: longLabels,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default,
                frame: CGRect(x: 0, y: 0, width: 600, height: 300)
            ),
            .init(
                scenario: self,
                intent: .basic,
                variant: .outlined,
                state: .normal,
                contentType: .text,
                size: .medium,
                orientation: .vertical,
                labels: longLabels,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default,
                frame: CGRect(x: 0, y: 0, width: 300, height: 300)
            )
        ]
    }
}
