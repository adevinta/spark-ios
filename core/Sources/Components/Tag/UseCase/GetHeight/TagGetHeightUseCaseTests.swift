//
//  TagGetHeightUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TagGetHeightUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_from_contentSizeCategory() {
        // GIVEN
        let items = ContentSizeCategoryStubs.cases
        for item in items {

            let getDynamicContentSizeUseCaseMock = GetDynamicContentSizeUseCaseableGeneratedMock()
            getDynamicContentSizeUseCaseMock.executeWithContentSizeCategoryReturnValue = item.givenDynamicContentSize

            let useCase = TagGetHeightUseCase(getDynamicContentSizeUseCase: getDynamicContentSizeUseCaseMock)

            // WHEN
            let height = useCase.execute(from: ContentSizeCategory.small)

            // THEN
            XCTAssertEqual(height,
                           item.expectedHeight,
                           "Wrong height value from contentSizeCategory for .\(item.givenDynamicContentSize) case")

            // **
            // GetDynamicContentSizeUseCase
            XCTAssertEqual(getDynamicContentSizeUseCaseMock.executeWithContentSizeCategoryCallsCount,
                           1,
                           "Wrong call number on execute on getDynamicContentSizeUseCase")
            XCTAssertEqual(getDynamicContentSizeUseCaseMock.executeWithContentSizeCategoryReceivedContentSizeCategory,
                           .small,
                           "Wrong parameter on execute on getDynamicContentSizeUseCase")
            // **
        }
    }

    func test_execute_from_uiContentSizeCategory() {
        // GIVEN
        let items = ContentSizeCategoryStubs.cases
        for item in items {

            let getDynamicContentSizeUseCaseMock = GetDynamicContentSizeUseCaseableGeneratedMock()
            getDynamicContentSizeUseCaseMock.executeWithUiContentSizeCategoryReturnValue = item.givenDynamicContentSize

            let useCase = TagGetHeightUseCase(getDynamicContentSizeUseCase: getDynamicContentSizeUseCaseMock)

            // WHEN
            let height = useCase.execute(from: UIContentSizeCategory.small)

            // THEN
            XCTAssertEqual(height,
                           item.expectedHeight,
                           "Wrong height value from uiContentSizeCategory for .\(item.givenDynamicContentSize) case")

            // **
            // GetDynamicContentSizeUseCase
            XCTAssertEqual(getDynamicContentSizeUseCaseMock.executeWithUiContentSizeCategoryCallsCount,
                           1,
                           "Wrong call number on execute on getDynamicContentSizeUseCase")
            XCTAssertEqual(getDynamicContentSizeUseCaseMock.executeWithUiContentSizeCategoryReceivedUiContentSizeCategory,
                           .small,
                           "Wrong parameter on execute on getDynamicContentSizeUseCase")
            // **
        }
    }
}

// MARK: - Stubs

private enum ContentSizeCategoryStubs {

    static let cases: [(givenDynamicContentSize: DynamicContentSize, expectedHeight: CGFloat)] = [
        (.xSmall, 20),
        (.small, 20),
        (.medium, 20),
        (.large, 20),
        (.xLarge, 22),
        (.xxLarge, 24),
        (.xxxLarge, 26),
        (.accessibility1, 32),
        (.accessibility2, 38),
        (.accessibility3, 45),
        (.accessibility4, 50),
        (.accessibility5, 60),
    ]
}
