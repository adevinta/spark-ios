//
//  TextLinkConfigurationSnapshotTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct TextLinkConfigurationSnapshotTests {

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Properties

    let scenario: TextLinkScenarioSnapshotTests

    let type: TextLinkType
    let variant: TextLinkVariant
    let image: ImageEither?
    let alignment: TextLinkAlignment
    let intent: TextLinkIntent
    let size: TextLinkSize
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Initialization

    init(
        scenario: TextLinkScenarioSnapshotTests,
        type: TextLinkType = .text,
        variant: TextLinkVariant = .underline,
        image: ImageEither? = nil,
        alignment: TextLinkAlignment = .leadingImage,
        intent: TextLinkIntent = .main,
        size: TextLinkSize = .size1,
        modes: [ComponentSnapshotTestMode] = Constants.Modes.default,
        sizes: [UIContentSizeCategory] = Constants.Sizes.default
    ) {
        self.scenario = scenario
        self.type = type
        self.variant = variant
        self.image = image
        self.alignment = alignment
        self.intent = intent
        self.size = size
        self.modes = modes
        self.sizes = sizes
    }

    // MARK: - Getter

    func testName() -> String {
        return [
            self.scenario.rawValue,
            self.type.rawValue,
            "\(self.intent)" + "Intent",
            "\(self.variant)" + "Variant",
            self.image != nil ? "\(self.alignment)" : nil,
            self.size.rawValue,
        ].compactMap { $0 }.joined(separator: "-")
    }
}

// MARK: - Enum

enum TextLinkType: String, CaseIterable {
    case text
    case paragraph

    // MARK: - All Cases

    var text: String {
        switch self {
        case .text:
            return "My Text"
        case .paragraph:
            return "My paragraphe\nwith many lines\nmany many lines"
        }
    }

    var textHighlightRange: NSRange? {
        switch self {
        case .text:
            return nil
        case .paragraph:
            return .init(location: 0, length: 13)
        }
    }
}

enum TextLinkSize: String, CaseIterable {
    case size1
    case size2

    // MARK: - Properties

    var typography: TextLinkTypography {
        switch self {
        case .size1:
            return .body1
        case .size2:
            return .headline1
        }
    }
}
