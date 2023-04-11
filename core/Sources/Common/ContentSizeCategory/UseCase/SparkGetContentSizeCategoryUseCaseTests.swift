//
//  SparkGetContentSizeCategoryUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 07/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


import XCTest
import SwiftUI
@testable import SparkCore

final class SparkGetContentSizeCategoryUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_from_contentSizeCategory_for_all_cases() {
        // GIVEN
        let items: [(givenSwiftUIContentSizeCategory: ContentSizeCategory, expectedContentSizeCategory: SparkContentSizeCategory)] = [
            (.extraSmall, .xSmall),
            (.small, .small),
            (.medium, .medium),
            (.large, .large),
            (.extraLarge, .xLarge),
            (.extraExtraLarge, .xxLarge),
            (.extraExtraExtraLarge, .xxxLarge),
            (.accessibilityMedium, .accessibility1),
            (.accessibilityLarge, .accessibility2),
            (.accessibilityExtraLarge, .accessibility3),
            (.accessibilityExtraExtraLarge, .accessibility4),
            (.accessibilityExtraExtraExtraLarge, .accessibility5)
        ]

        for item in items {
            let useCase = SparkGetContentSizeCategoryUseCase()

            // WHEN
            let contentSizeCategory = useCase.execute(from: item.givenSwiftUIContentSizeCategory)

            // THEN
            XCTAssertEqual(contentSizeCategory,
                           item.expectedContentSizeCategory,
                           "Wrong fromContentSizeCategory init for .\(item.expectedContentSizeCategory) case")
        }
    }

    func test_execute_from_uiContentSizeCategory_for_all_cases() {
        // GIVEN / WHEN
        let items: [(givenUIContentSizeCategory: UIContentSizeCategory, expectedContentSizeCategory: SparkContentSizeCategory)] = [
            (.unspecified, .medium),
            (.extraSmall, .xSmall),
            (.small, .small),
            (.medium, .medium),
            (.large, .large),
            (.extraLarge, .xLarge),
            (.extraExtraLarge, .xxLarge),
            (.extraExtraExtraLarge, .xxxLarge),
            (.accessibilityMedium, .accessibility1),
            (.accessibilityLarge, .accessibility2),
            (.accessibilityExtraLarge, .accessibility3),
            (.accessibilityExtraExtraLarge, .accessibility4),
            (.accessibilityExtraExtraExtraLarge, .accessibility5),
            (.init(rawValue: ""), .medium)
        ]

        for item in items {
            let useCase = SparkGetContentSizeCategoryUseCase()

            // WHEN
            let contentSizeCategory = useCase.execute(from: item.givenUIContentSizeCategory)

            XCTAssertEqual(contentSizeCategory,
                           item.expectedContentSizeCategory,
                           "Wrong fromUIContentSizeCategory init for .\(item.expectedContentSizeCategory) case")
        }
    }
}
