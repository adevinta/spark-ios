//
//  TagSutSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
@testable import SparkCore

struct TagSutSnapshotTests {

    // MARK: - Properties

    let scenario: TagScenarioSnapshotTests

    let intent: TagIntent
    let variant: TagVariant
    let iconImage: ImageEither?
    let text: String?
    let isLongText: Bool
    var width: CGFloat? {
        return self.isLongText ? 100 : nil
    }
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(self.intent)",
            "\(self.variant)",
            self.iconImage != nil ? "withImage" : "withoutImage",
            self.text != nil ? (self.isLongText ? "longText" : "normalText") : "withoutText"
        ].joined(separator: "-")
    }
}
