//
//  ChipScenarioSnapshotTests.swift
//  Spark
//
//  Created by michael.zimmermann on 26.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum ChipScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
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
    ///  - variant: outlined
    ///  - content: icon + text
    ///  - state: default
    ///  - mode: all
    ///  - size: default
    private func test1(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
        let intents = ChipIntent.allCases

        return intents.map {
            .init(
                scenario: self,
                intent: $0,
                variant: .outlined,
                icon: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: "Label",
                badge: nil,
                state: .default,
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
    ///  - intent: basic
    ///  - variant: all
    ///  - content: text only
    ///  - state: default
    ///  - mode: all
    ///  - size: default
    private func test2(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
        let variants = ChipVariant.allCases

        return variants.map {
            .init(
                scenario: self,
                intent: .basic,
                variant: $0,
                icon: nil,
                text: "Label",
                badge: nil,
                state: .default,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test all states
    ///
    /// Content:
    ///  - intents: all
    ///  - variant: all
    ///  - content: icon + text
    ///  - state: all
    ///  - mode: default
    ///  - size: default
    private func test3(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
        let variants = ChipVariant.allCases
        let states = ChipState.all

        return all(variants, states).map { variant, state in
                .init(
                    scenario: self,
                    intent: .main,
                    variant: variant,
                    icon: .mock(isSwiftUIComponent: isSwiftUIComponent),
                    text: "Label", 
                    badge: nil,
                    state: state,
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
    ///  - content: text + icon + in different combinations
    ///  - mode: default
    ///  - size: default
    private func test4(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
        let contents: [(hasIcon: Bool, hasText: Bool, hasBadge: Bool)] =
        [
            (true, false, false),
            (true, false, true),
            (false, true, true),
            (true, true, true)
        ]

        return contents.map { content in
            .init(
                scenario: self,
                intent: .neutral,
                variant: .tinted,
                icon: content.hasIcon ? .mock(isSwiftUIComponent: isSwiftUIComponent) : nil,
                text: content.hasText ? "A Very Long Label" : nil,
                badge: content.hasBadge ? .mock(isSwiftUIComponent) : nil,
                state: .default,
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
    private func test5(isSwiftUIComponent: Bool) -> [ChipConfigurationSnapshotTests] {
        return [
            .init(
                scenario: self,
                intent: .accent,
                variant: .tinted,
                icon: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: "Label",
                badge: nil,
                state: .default,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        ]
    }
}

// MARK: - Private Extensions
private extension ImageEither {
    static func mock(isSwiftUIComponent: Bool) -> Self {
        return isSwiftUIComponent ? .right(Image.mock) : .left(UIImage.mock)
    }
}

private extension ViewEither {
    static func mock(_ isSwiftUIComponent: Bool) -> Self {
        if isSwiftUIComponent {
            let view = BadgeView(
                theme: SparkTheme.shared,
                intent: .danger,
                value: 99
            ).borderVisible(false)

            return .right(AnyView(view))
        } else {
            let view = BadgeUIView(
                theme: SparkTheme.shared,
                intent: .danger,
                value: 99,
                isBorderVisible: false
            )
            return .left(view)
        }
    }
}

private extension Image {
    static let mock = Image(systemName: "person.2.circle.fill")
}

private extension UIImage {
    static var mock = UIImage(systemName: "person.2.circle.fill") ?? UIImage()
}

private func all<U, V>(_ lhs: [U], _ rhs: [V]) -> [(U, V)] {
    lhs.flatMap { left in
        rhs.map { right in
            (left, right)
        }
    }
}
