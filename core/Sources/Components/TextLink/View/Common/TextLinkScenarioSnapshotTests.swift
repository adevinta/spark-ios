//
//  TextLinkScenarioSnapshotTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum TextLinkScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [TextLinkConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
        case .test3:
            return self.test3()
        case .test4:
            return self.test4(isSwiftUIComponent: isSwiftUIComponent)
        case .test5:
            return self.test5(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all types of link
    ///
    /// Content:
    /// - type: all
    /// - underline: default
    /// - with icon: default
    /// - icon aligment: default
    /// - intent: default
    /// - size: default
    /// - a11y size: default
    /// - mode: all
    private func test1() -> [TextLinkConfigurationSnapshotTests] {
        let typePossibilities = TextLinkType.allCases

        return typePossibilities.map { type in
            .init(
                scenario: self,
                type: type,
                modes: Constants.Modes.all
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test inheritance
    ///
    /// Content:
    /// - type: default
    /// - underline: default
    /// - with icon: true
    /// - icon aligment: default
    /// - intent: all
    /// - size: all
    /// - a11y size: default
    /// - mode: default
    private func test2(isSwiftUIComponent: Bool) -> [TextLinkConfigurationSnapshotTests] {
        let intentsPossibilities = TextLinkIntent.allCases
        let sizesPossibilities = TextLinkSize.allCases

        return intentsPossibilities.flatMap { intent in
            sizesPossibilities.map { size in
                return .init(
                    scenario: self,
                    image: .mock(isSwiftUIComponent: isSwiftUIComponent),
                    intent: intent,
                    size: size
                )
            }
        }
    }

    /// Test 3
    ///
    /// Description: To test underline
    ///
    /// Content:
    /// - type: default
    /// - underline: all
    /// - with icon: default
    /// - icon aligment: default
    /// - intent: default
    /// - size: default
    /// - a11y size: default
    /// - mode: default
    private func test3() -> [TextLinkConfigurationSnapshotTests] {
        let variantPossibilities = TextLinkVariant.allCases

        return variantPossibilities.map { variant in
            .init(
                scenario: self,
                variant: variant
            )
        }
    }

    /// Test 4
    ///
    /// Description: To test with icons
    ///
    /// Content:
    /// - type: all
    /// - underline: default
    /// - with icon: true
    /// - icon aligment: all
    /// - intent: default
    /// - size: default
    /// - a11y size: default
    /// - mode: default
    private func test4(isSwiftUIComponent: Bool) -> [TextLinkConfigurationSnapshotTests] {
        let typePossibilities = TextLinkType.allCases
        let alignmentPossibilities = TextLinkAlignment.allCases

        return typePossibilities.flatMap { type in
            alignmentPossibilities.map { alignment in
                    .init(
                        scenario: self,
                        type: type,
                        image: .mock(isSwiftUIComponent: isSwiftUIComponent),
                        alignment: alignment
                    )
            }
        }
    }

    /// Test 5
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    /// - type: default
    /// - underline: default
    /// - with icon: default
    /// - icon aligment: default
    /// - intent: default
    /// - size: default
    /// - a11y size: all
    /// - mode: default
    private func test5(isSwiftUIComponent: Bool) -> [TextLinkConfigurationSnapshotTests] {
        return [
            .init(
                scenario: self,
                sizes: Constants.Sizes.all
            )
        ]
    }
}
