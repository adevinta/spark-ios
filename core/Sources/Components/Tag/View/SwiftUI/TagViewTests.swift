//
//  TagViewTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class TagViewTests: SwiftUIComponentTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared
    private var iconImage = Image(systemName: "square.and.arrow.up")
    private let text = "Text"

    // MARK: - Tests

    func test_swiftUI_tag_with_only_image_for_all_intentColor_and_variant() throws {
        let suts = TagSutTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intentColor(sut.intentColor)
                .variant(sut.variant)
                .iconImage(self.iconImage)
                .fixedSize().environment(\.sizeCategory, .medium)

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }

    func test_swiftUI_tag_with_only_text_for_all_intentColor_and_variant() {
        let suts = TagSutTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intentColor(sut.intentColor)
                .variant(sut.variant)
                .text(self.text)
                .fixedSize().environment(\.sizeCategory, .medium)

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }

    func test_swiftUI_tag_with_image_and_text_for_all_intentColor_and_variant() throws {
        let suts = TagSutTests.allCases
        for sut in suts {
            let view = TagView(theme: self.theme)
                .intentColor(sut.intentColor)
                .variant(sut.variant)
                .iconImage(self.iconImage)
                .text(self.text)
                .fixedSize().environment(\.sizeCategory, .medium)

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName()
            )
        }
    }
}
