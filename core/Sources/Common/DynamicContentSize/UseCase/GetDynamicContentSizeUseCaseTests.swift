//
//  GetDynamicContentSizeUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 07/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//


import XCTest
import SwiftUI
@testable import SparkCore

final class GetDynamicContentSizeUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_from_contentSizeCategory_for_all_cases() {
        // GIVEN
        let items: [(givenContentSizeCategory: ContentSizeCategory, expectedDynamicContentSize: DynamicContentSize)] = [
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
            let useCase = GetDynamicContentSizeUseCase()

            // WHEN
            let contentSizeCategory = useCase.execute(from: item.givenContentSizeCategory)

            // THEN
            XCTAssertEqual(contentSizeCategory,
                           item.expectedDynamicContentSize,
                           "Wrong fromContentSizeCategory init for .\(item.expectedDynamicContentSize) case")
        }
    }

    func test_execute_from_uiContentSizeCategory_for_all_cases() {
        // GIVEN / WHEN
        let items: [(givenUIContentSizeCategory: UIContentSizeCategory, expectedDynamicContentSize: DynamicContentSize)] = [
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
            let useCase = GetDynamicContentSizeUseCase()

            // WHEN
            let contentSizeCategory = useCase.execute(from: item.givenUIContentSizeCategory)

            XCTAssertEqual(contentSizeCategory,
                           item.expectedDynamicContentSize,
                           "Wrong fromUIContentSizeCategory init for .\(item.expectedDynamicContentSize) case")
        }
    }
}
