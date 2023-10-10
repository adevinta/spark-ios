//
//  TagSutSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
@testable import SparkCore

struct TagSutSnapshotTests {

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Properties

    let strategy: TagSutSnapshotStrategy

    let intent: TagIntent
    let variant: TagVariant
    let iconImage: ImageEither?
    let text: String?
    private let isLongText: Bool
    var width: CGFloat? {
        return self.isLongText ? 100 : nil
    }
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.strategy.rawValue)",
            "\(self.intent)",
            "\(self.variant)",
            self.iconImage != nil ? "withImage" : "withoutImage",
            self.isLongText ? "longText" : "normalText"
        ].joined(separator: "-")
    }

    // MARK: - Testing Strategy

    static func test(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        switch strategy {
        case .test1:
            return self.test1(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        case .test2:
            return self.test2(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        case .test3:
            return self.test3(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        case .test4:
            return self.test4(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        case .test5:
            return self.test5(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        case .test6:
            return self.test6(
                for: strategy,
                isSwiftUIComponent: isSwiftUIComponent
            )
        }
    }

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intents: all
    ///  - variant : tinted
    ///  - content : icon + text
    ///  - theme : light / dark
    ///  - size : default
    static func test1(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        let intents = TagIntent.allCases

        return intents.map {
            .init(
                strategy: strategy,
                intent: $0,
                variant: .tinted,
                iconImage: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: "Text",
                isLongText: false,
                modes: Constants.modes,
                sizes: [Constants.size]
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all variants
    ///
    /// Content:
    ///  - intent: main
    ///  - variant : all
    ///  - content : text only
    ///  - theme : light / dark
    ///  - size : default
    static func test2(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        let variants = TagVariant.allCases

        return variants.map {
            .init(
                strategy: strategy,
                intent: .main,
                variant: $0,
                iconImage: nil,
                text: "Text",
                isLongText: false,
                modes: Constants.modes,
                sizes: [Constants.size]
            )
        }
    }

    /// Test 3
    ///
    /// Description: To test all color for filled variant
    ///
    /// Content:
    ///  - intents: all
    ///  - variant : filled
    ///  - content : icon + text
    ///  - theme : default
    ///  - size : default
    static func test3(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        let intents = TagIntent.allCases

        return intents.map {
            .init(
                strategy: strategy,
                intent: $0,
                variant: .filled,
                iconImage: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: "Text",
                isLongText: false,
                modes: [Constants.mode],
                sizes: [Constants.size]
            )
        }
    }

    /// Test 4
    ///
    /// Description: To test content resilience
    ///
    /// Content:
    ///  - intent: neutral
    ///  - variant : tinted
    ///  - content : icon only
    ///  - theme : default
    ///  - size : default
    static func test4(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        return [
            .init(
                strategy: strategy,
                intent: .neutral,
                variant: .tinted,
                iconImage: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: nil,
                isLongText: false,
                modes: [Constants.mode],
                sizes: [Constants.size]
            )
        ]
    }

    /// Test 5
    ///
    /// Description: To test content resilience
    ///
    /// Content:
    ///  - intent: neutral
    ///  - variant : tinted
    ///  - content : long text
    ///  - theme : default
    ///  - size : default
    static func test5(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        return [
            .init(
                strategy: strategy,
                intent: .neutral,
                variant: .tinted,
                iconImage: nil,
                text: "Very very very long long text",
                isLongText: true,
                modes: [Constants.mode],
                sizes: [Constants.size]
            )
        ]
    }

    /// Test 6
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - intent: main
    ///  - variant : tinted
    ///  - content : icon + text
    ///  - theme : default
    ///  - size :  xs, medium, xxxl
    static func test6(
        for strategy: TagSutSnapshotStrategy,
        isSwiftUIComponent: Bool
    ) -> [TagSutSnapshotTests] {
        return [
            .init(
                strategy: strategy,
                intent: .main,
                variant: .tinted,
                iconImage: .mock(isSwiftUIComponent: isSwiftUIComponent),
                text: "Text",
                isLongText: false,
                modes: [Constants.mode],
                sizes: Constants.sizes
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

private extension Image {
    static let mock = Image(systemName: "person.2.circle.fill")
}

private extension UIImage {
    static var mock = UIImage(systemName: "person.2.circle.fill") ?? UIImage()
}
