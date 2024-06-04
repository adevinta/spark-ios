//
//  TagConfigurationSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommonTesting

struct TagConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: TagScenarioSnapshotTests

    let intent: TagIntent
    let variant: TagVariant
    let content: TagContentType
    var width: CGFloat? {
        return self.content.isLongText ? 100 : nil
    }
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.variant)",
            "\(self.content.name)",
        ].joined(separator: "-")
    }
}

// MARK: - Enum

enum TagContentType {
    case text(_ value: String)
    case longText(_ value: String)
    case attributedText(_ value: AttributedStringEither)
    case icon(_ image: ImageEither)
    case iconAndText(_ image: ImageEither, _ value: String)
    case iconAndLongText(_ image: ImageEither, _ value: String)
    case iconAndAttributedText(_ image: ImageEither, _ value: AttributedStringEither)

    // MARK: - Properties

    var name: String {
        switch self {
        case .text:
            return "text"
        case .longText:
            return "longText"
        case .attributedText:
            return "attributedText"
        case .icon:
            return "icon"
        case .iconAndText:
            return "iconAndText"
        case .iconAndLongText:
            return "iconAndLongText"
        case .iconAndAttributedText:
            return "iconAndAttributedText"
        }
    }

    var isLongText: Bool {
        switch self {
        case .longText, .iconAndLongText:
            return true
        default:
            return false
        }
    }

    // MARK: - Constants

    enum Constants {
        static var text: String = "Text"
        static var longText: String = "Very very long long text"
        static func attributedText(isSwiftUIComponent: Bool) -> AttributedStringEither {
            return .mock(
                isSwiftUIComponent: isSwiftUIComponent,
                text: "My AT Text",
                fontSize: 14
            )
        }
        static func icon(isSwiftUIComponent: Bool) -> ImageEither {
            return .mock(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Cases

    static func allCasesExceptText(isSwiftUIComponent: Bool) -> [Self] {
        return [
            .text(Constants.text),
            .longText(Constants.longText),
            .attributedText(Constants.attributedText(isSwiftUIComponent: isSwiftUIComponent)),
            .icon(Constants.icon(isSwiftUIComponent: isSwiftUIComponent)),
            .iconAndText(
                Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                Constants.text
            ),
            .iconAndLongText(
                Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                Constants.longText
            ),
            .iconAndAttributedText(
                Constants.icon(isSwiftUIComponent: isSwiftUIComponent),
                Constants.attributedText(isSwiftUIComponent: isSwiftUIComponent)
            )
        ]
    }
}
