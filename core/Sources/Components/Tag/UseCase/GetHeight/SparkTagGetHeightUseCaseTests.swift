//
//  SparkTagGetHeightUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SparkTagGetHeightUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_from_contentSizeCategory() {
        // GIVEN
        let items = ContentSizeCategoryStubs.cases
        for item in items {

            let getContentSizeCategoryUseCaseMock = SparkGetContentSizeCategoryUseCaseableGeneratedMock()
            getContentSizeCategoryUseCaseMock.executeWithContentSizeCategoryReturnValue = item.givenContentSizeCategory

            let useCase = SparkTagGetHeightUseCase(getContentSizeCategory: getContentSizeCategoryUseCaseMock)

            // WHEN
            let height = useCase.execute(from: ContentSizeCategory.small)

            // THEN
            XCTAssertEqual(height,
                           item.expectedHeight,
                           "Wrong height value from contentSizeCategory for .\(item.givenContentSizeCategory) case")

            // **
            // GetContentSizeCategoryUseCase
            XCTAssertEqual(getContentSizeCategoryUseCaseMock.executeWithContentSizeCategoryCallsCount,
                           1,
                           "Wrong call number on execute on getContentSizeCategoryUseCase")
            XCTAssertEqual(getContentSizeCategoryUseCaseMock.executeWithContentSizeCategoryReceivedContentSizeCategory,
                           .small,
                           "Wrong parameter on execute on getContentSizeCategoryUseCase")
            // **
        }
    }

    func test_execute_from_uiContentSizeCategory() {
        // GIVEN
        let items = ContentSizeCategoryStubs.cases
        for item in items {

            let getContentSizeCategoryUseCaseMock = SparkGetContentSizeCategoryUseCaseableGeneratedMock()
            getContentSizeCategoryUseCaseMock.executeWithUiContentSizeCategoryReturnValue = item.givenContentSizeCategory

            let useCase = SparkTagGetHeightUseCase(getContentSizeCategory: getContentSizeCategoryUseCaseMock)

            // WHEN
            let height = useCase.execute(from: UIContentSizeCategory.small)

            // THEN
            XCTAssertEqual(height,
                           item.expectedHeight,
                           "Wrong height value from uiContentSizeCategory for .\(item.givenContentSizeCategory) case")

            // **
            // GetContentSizeCategoryUseCase
            XCTAssertEqual(getContentSizeCategoryUseCaseMock.executeWithUiContentSizeCategoryCallsCount,
                           1,
                           "Wrong call number on execute on getContentSizeCategoryUseCase")
            XCTAssertEqual(getContentSizeCategoryUseCaseMock.executeWithUiContentSizeCategoryReceivedUiContentSizeCategory,
                           .small,
                           "Wrong parameter on execute on getContentSizeCategoryUseCase")
            // **
        }
    }
}

// MARK: - Stubs

private enum ContentSizeCategoryStubs {

    static let cases: [(givenContentSizeCategory: SparkContentSizeCategory, expectedHeight: CGFloat)] = [
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
