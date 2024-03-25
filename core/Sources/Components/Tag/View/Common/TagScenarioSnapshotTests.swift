//
//  TagScenarioSnapshotTestsTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 10/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum TagScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
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
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intents: all
    ///  - variant: tinted
    ///  - content: icon + text
    ///  - mode: all
    ///  - size: default
    private func test1(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
        let intents = TagIntent.allCases

        return intents.map {
            .init(
                scenario: self,
                intent: $0,
                variant: .tinted,
                content: .iconAndText(
                    TagContentType.Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                    TagContentType.Constants.text
                ),
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all variants
    ///
    /// Content:
    ///  - intent: main
    ///  - variant: all
    ///  - content: text only
    ///  - mode: all
    ///  - size: default
    private func test2(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
        let variants = TagVariant.allCases

        return variants.map {
            .init(
                scenario: self,
                intent: .main,
                variant: $0,
                content: .text(TagContentType.Constants.text),
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test all color for filled variant
    ///
    /// Content:
    ///  - intents: all
    ///  - variant: filled
    ///  - content: icon + text
    ///  - mode: default
    ///  - size: default
    private func test3(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
        let intents = TagIntent.allCases

        return intents.map {
            .init(
                scenario: self,
                intent: $0,
                variant: .filled,
                content: .iconAndText(
                    TagContentType.Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                    TagContentType.Constants.text
                ),
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 4
    ///
    /// Description: To test content resilience
    ///
    /// Content:
    ///  - intent: neutral
    ///  - variant: tinted
    ///  - content: all (icon only / long text / long text + icon / attributed text / attributed text + icon)
    ///  - mode: default
    ///  - size: default
    private func test4(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
        let contents = TagContentType.allCasesExceptText(isSwiftUIComponent: isSwiftUIComponent)

        return contents.map {
            .init(
                scenario: self,
                intent: .neutral,
                variant: .tinted,
                content: $0,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 6
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - intent: main
    ///  - variant: tinted
    ///  - content: icon + text
    ///  - mode: default
    ///  - size:  all
    private func test5(isSwiftUIComponent: Bool) -> [TagConfigurationSnapshotTests] {
        return [
            .init(
                scenario: self,
                intent: .main,
                variant: .tinted,
                content: .iconAndText(
                    TagContentType.Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                    TagContentType.Constants.text
                ),
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        ]
    }
}
