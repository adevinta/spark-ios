//
//  XXXConfigurationSnapshotTests.swift
//  SparkComponentXXXSnapshotTests
//
//  Created by robin.lemaire on 02/03/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import UIKit
@testable import SparkComponentXXX
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting

struct XXXConfigurationSnapshotTests {

    // MARK: - Properties

    let scenario: XXXScenarioSnapshotTests

    var intent: XXXIntent = .default
    var size: XXXSize = .default
    var apportionsSegmentWidthsByContent: Bool = false
    var content: XXXContent = .default
    var contentType: XXXContentType = .default
    var selectedIndex: Int = 1

    var modes: [ComponentSnapshotTestMode] = ComponentSnapshotTestConstants.Modes.default
    var sizes: [UIContentSizeCategory] = ComponentSnapshotTestConstants.Sizes.default

    // MARK: - Name

    var name: String {
        guard self.documentationName == nil else {
            return ""
        }

        return [
            "\(self.intent)" + "Intent",
            "\(self.size)" + "Size",
            !self.apportionsSegmentWidthsByContent ? "fitToParentWidth" : "scrollable",
            "\(self.contentType)" + "ContentType",
            "\(self.content)" + "Content",
            self.selectedIndex >= 0 ? "selectedIndex\(self.selectedIndex)" : "noSelection"
        ]
            .compactMap { $0 }
            .joined(separator: "-")
    }

    var testName: String {
        return if let documentationName {
            "xxx_" + documentationName
        } else {
            self.scenario.rawValue
        }
    }

    var documentationName: String?
}

// MARK: - Enum

enum XXXContent: String, CaseIterable {
    case text
    case icon
    case textAndIcon
    case textAndExtraView
    case iconAndExtraView
    case allValues

    static var `default` = Self.text

    var documentationName: String? {
        switch self {
        case .text: "texts"
        case .icon: "icons"
        case .textAndIcon: nil
        case .textAndExtraView: "extra_view"
        case .iconAndExtraView: nil
        case .allValues: "all_values"
        }
    }
}

enum XXXContentType: String, CaseIterable {
    case text
    case custom

    static var `default` = Self.text
}
