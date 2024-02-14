//
//  IconButtonScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI

enum IconButtonScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) throws -> [IconButtonConfigurationSnapshotTests] {
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
    /// - **intents: all**
    /// - alignment: default
    /// - shape: default
    /// - size: default
    /// - variant: default
    /// - content: default
    /// - state: default
    /// - mode: all
    /// - a11y: default
    private func test1(isSwiftUIComponent: Bool) -> [IconButtonConfigurationSnapshotTests] {
        let intents = ButtonIntent.allCases

        return intents.compactMap { intent -> IconButtonConfigurationSnapshotTests? in
            guard let image =  ImageEither.mock(
                isSwiftUIComponent: isSwiftUIComponent,
                for: .normal
            ) else {
                return nil
            }

            return .init(
                scenario: self,
                intent: intent,
                image: image,
                modes: Constants.Modes.all
            )
        }
    }

    /// Test 2
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
    private func test2(isSwiftUIComponent: Bool) -> [IconButtonConfigurationSnapshotTests] {
        let shapes = ButtonShape.allCases

        return shapes.compactMap { shape -> IconButtonConfigurationSnapshotTests? in
            guard let image =  ImageEither.mock(
                isSwiftUIComponent: isSwiftUIComponent,
                for: .normal
            ) else {
                return nil
            }

            return .init(
                scenario: self,
                shape: shape,
                image: image,
                sizes: Constants.Sizes.all
            )
        }
    }

    /// Test 3
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
    private func test3(isSwiftUIComponent: Bool) -> [IconButtonConfigurationSnapshotTests] {
        let sizes = ButtonSize.allCases

        return sizes.compactMap { size -> IconButtonConfigurationSnapshotTests? in
            guard let image =  ImageEither.mock(
                isSwiftUIComponent: isSwiftUIComponent,
                for: .normal
            ) else {
                return nil
            }

            return .init(
                scenario: self,
                size: size,
                image: image,
                sizes: Constants.Sizes.all
            )
        }
    }

    /// Test 4
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
    private func test4(isSwiftUIComponent: Bool) -> [IconButtonConfigurationSnapshotTests] {
        let variants = ButtonVariant.allCases

        return variants.compactMap { variant -> IconButtonConfigurationSnapshotTests? in
            guard let image =  ImageEither.mock(
                isSwiftUIComponent: isSwiftUIComponent,
                for: .normal
            ) else {
                return nil
            }

            return .init(
                scenario: self,
                variant: variant,
                image: image
            )
        }
    }

    /// Test 5
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
    private func test5(isSwiftUIComponent: Bool) -> [IconButtonConfigurationSnapshotTests] {
        let states = ControlState.allCases

        return states.compactMap { state -> IconButtonConfigurationSnapshotTests? in
            guard let image = ImageEither.mock(
                isSwiftUIComponent: isSwiftUIComponent,
                for: state
            ) else { return nil }

            return .init(
                scenario: self,
                image: image,
                state: state
            )
        }
    }
}

// MARK: - Extension

extension ImageEither {

    static func mock(
        isSwiftUIComponent: Bool,
        for state: ControlState
    ) -> Self? {
        switch state {
        case .normal:
            return isSwiftUIComponent ? .right(.normalMock) : .left(.normalMock)
        case .highlighted:
            return isSwiftUIComponent ? nil : .left(.highlightedMock)
        case .disabled:
            return isSwiftUIComponent ? .right(.disabledMock) : .left(.disabledMock)
        case .selected:
            return isSwiftUIComponent ? .right(.selectedMock) : .left(.selectedMock)
        }
    }
}

private extension Image {
    static var normalMock = Image(systemName: "arrow.right.square")
    static let disabledMock = Image(systemName: "arrow.up.square")
    static let selectedMock = Image(systemName: "arrow.down.square")
}

private extension UIImage {
    static var normalMock = IconographyTests.shared.arrow
    static var highlightedMock = IconographyTests.shared.checkmark
    static var disabledMock = IconographyTests.shared.switchOn
    static var selectedMock = IconographyTests.shared.switchOff
}
