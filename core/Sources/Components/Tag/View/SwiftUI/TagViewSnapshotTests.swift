//
//  TagViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import SparkCore

final class TagViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared
    private var iconImage = Image(systemName: "person.2.circle.fill")
    private let text = "Text"

    // MARK: - Tests

    func test_swiftUI_tag_with_only_image_for_all_intent_and_variant() throws {
        let suts = TagSutSnapshotTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intent(sut.intent)
                .variant(sut.variant)
                .iconImage(self.iconImage)
                .fixedSize()

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }

    func test_swiftUI_tag_with_only_text_for_all_intent_and_variant() {
        let suts = TagSutSnapshotTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intent(sut.intent)
                .variant(sut.variant)
                .text(self.text)
                .fixedSize()

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }

    func test_swiftUI_tag_with_image_and_text_for_all_intent_and_variant() throws {
        let suts = TagSutSnapshotTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intent(sut.intent)
                .variant(sut.variant)
                .iconImage(self.iconImage)
                .text(self.text)
                .fixedSize()

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }
}
