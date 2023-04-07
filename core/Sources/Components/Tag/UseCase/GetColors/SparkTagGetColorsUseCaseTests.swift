//
//  SparkTagGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SparkTagGetColorsUseCaseTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_execute_from_contentSizeCategory() {
        // GIVEN
        let variants = SparkTagVariant.allCases

        for variant in variants {
            let themeColors = ColorsGeneratedMock()

            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColors

            let intentColorMock: SparkTagIntentColor = .success
            let themingMock = SparkTagTheming(theme: themeMock,
                                              intentColor: intentColorMock,
                                              variant: variant)

            let intentColorsMock = SparkTagIntentColorablesGeneratedMock()

            let getIntentColorsUseCaseMock = SparkTagGetIntentColorsUseCaseableGeneratedMock()
            getIntentColorsUseCaseMock.executeWithIntentColorAndColorsReturnValue = intentColorsMock

            let useCase = SparkTagGetColorsUseCase(getIntentColorsUseCase: getIntentColorsUseCaseMock)

            // WHEN
            let colors = useCase.execute(from: themingMock)

            // THEN
//            XCTAssertEqual(colors,
//                           item.expectedHeight,
//                           "Wrong height value from contentSizeCategory for .\(item.givenContentSizeCategory) case")

            // **
            // GetIntentColorsUseCase
            let getIntentColorsUseCaseArgs = getIntentColorsUseCaseMock.executeWithIntentColorAndColorsReceivedArguments
            XCTAssertEqual(getIntentColorsUseCaseMock.executeWithIntentColorAndColorsCallsCount,
                           1,
                           "Wrong call number on execute on getIntentColorsUseCase")
            XCTAssertEqual(getIntentColorsUseCaseArgs?.intentColor,
                           intentColorMock,
                           "Wrong intentColor parameter on execute on getIntentColorsUseCase")
            XCTAssertIdentical(getIntentColorsUseCaseArgs?.colors as? ColorsGeneratedMock,
                               themeColors,
                               "Wrong colors parameter on execute on getIntentColorsUseCase")
            // **
        }
    }
}
