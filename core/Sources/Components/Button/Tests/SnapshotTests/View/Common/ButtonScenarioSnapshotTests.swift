//
//  ButtonScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum ButtonScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5
    case test6
    case test7

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) throws -> [ButtonConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
        case .test3:
            return self.test3()
        case .test4:
            return self.test4()
        case .test5:
            return self.test5()
        case .test6:
            return self.test6(isSwiftUIComponent: isSwiftUIComponent)
        case .test7:
            return self.test7(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    /// - **intents: all**
    /// - alignment: default
    /// - shape: default
    /// - size: default
    /// - variant: default
    /// - content: default
    /// - state: default
    /// - mode: all
    /// - a11y: default
    private func test1() -> [ButtonConfigurationSnapshotTests] {
        let intents = ButtonIntent.allCases

        return intents.map { intent -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    intent: intent,
                    modes: Constants.Modes.all
                )
        }
    }

    /// Test 2
    ///
    /// Description: To test all alignments
    ///
    /// Content:
    /// - intent: default
    /// - **alignments: all**
    /// - shapes: default
    /// - size: default
    /// - variant: default
    /// - content: default
    /// - state: default
    /// - mode: default
    /// - a11y: default
    private func test2(isSwiftUIComponent: Bool) -> [ButtonConfigurationSnapshotTests] {
        let alignments = ButtonAlignment.allCases

        return alignments.map { alignment -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    alignment: alignment,
                    content: .titleAndImage(
                        "My Title",
                        .mock(isSwiftUIComponent: isSwiftUIComponent)
                    )
                )
        }
    }

    /// Test 3
    ///
    /// Description: To test all shapes for all a11y sizes
    ///
    /// Content:
    /// - intent: default
    /// - alignment: default
    /// - **shapes: all**
    /// - size: default
    /// - variant: default
    /// - content: default
    /// - state: default
    /// - mode: default
    /// - **a11y: all**
    private func test3() -> [ButtonConfigurationSnapshotTests] {
        let shapes = ButtonShape.allCases

        return shapes.map { shape -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    shape: shape,
                    sizes: Constants.Sizes.all
                )
        }
    }

    /// Test 4
    ///
    /// Description: To test all sizes for all a11y sizes
    ///
    /// Content:
    /// - intent: default
    /// - alignment: default
    /// - shape: default
    /// - **sizes: all**
    /// - variant: default
    /// - content: default
    /// - state: default
    /// - mode: default
    /// - **a11y: all**
    private func test4() -> [ButtonConfigurationSnapshotTests] {
        let sizes = ButtonSize.allCases

        return sizes.map { size -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    size: size,
                    sizes: Constants.Sizes.all
                )
        }
    }

    /// Test 5
    ///
    /// Description: To test all variants
    ///
    /// Content:
    /// - intent: default
    /// - alignment: default
    /// - shape: default
    /// - size: default
    /// - **variants: all**
    /// - content: default
    /// - state: default
    /// - mode: default
    /// - a11y: default
    private func test5() -> [ButtonConfigurationSnapshotTests] {
        let variants = ButtonVariant.allCases

        return variants.map { variant -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    variant: variant
                )
        }
    }

    /// Test 6
    ///
    /// Description: To test all contents
    ///
    /// Content:
    /// - intent: default
    /// - alignment: default
    /// - shape: default
    /// - size: default
    /// - variants: default
    /// - **contents: all**
    /// - state: default
    /// - mode: default
    /// - a11y: default
    private func test6(isSwiftUIComponent: Bool) -> [ButtonConfigurationSnapshotTests] {
        let contents = ButtonContentType.allCases(isSwiftUIComponent: isSwiftUIComponent)

        return contents.map { content -> ButtonConfigurationSnapshotTests in
                .init(
                    scenario: self,
                    content: content
                )
        }
    }

    /// Test 7
    ///
    /// Description: To test all states
    ///
    /// Content:
    /// - intent: default
    /// - alignment: default
    /// - shape: default
    /// - size: default
    /// - variant: default
    /// - content: default
    /// - **states: all**
    /// - mode: default
    /// - a11y: default
    private func test7(isSwiftUIComponent: Bool) -> [ButtonConfigurationSnapshotTests] {
        let states = ControlState.allCases

        return states.compactMap { state -> ButtonConfigurationSnapshotTests? in

            let title: String?
            switch state {
            case .normal:
                title = "Normal"
            case .highlighted:
                // We can't test highlighted for SwiftUI
                title = isSwiftUIComponent ? nil : "Highlighted"
            case .disabled:
                title = "Disabled"
            case .selected:
                title = "Selected"
            }

            guard let title else { return nil }

            return .init(
                scenario: self,
                content: .title(title),
                state: state
            )
        }
    }
}

// MARK: - Extension

extension ButtonContentType {

    static func allCases(isSwiftUIComponent: Bool) -> [Self] {
        let image = ImageEither.mock(isSwiftUIComponent: isSwiftUIComponent)
        let attributedString = AttributedStringEither.mock(isSwiftUIComponent: isSwiftUIComponent)

        return self.allCases(
            attributedTitle: attributedString,
            image: image
        )
    }
}
