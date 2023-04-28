//
//  TagViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 27/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TagViewModelTests: XCTestCase {

    // MARK: - Tests

    func test_execute_from_contentSizeCategory() {
        // GIVEN
        let tagColorsMock = TagColorablesGeneratedMock()

        let themeTypographyMock = TypographyGeneratedMock()
        let themeBorderMock = BorderGeneratedMock()
        let themeSpacingMock = LayoutSpacingGeneratedMock()
        let themeLayoutMock = LayoutGeneratedMock()
        themeLayoutMock.underlyingSpacing = themeSpacingMock
        let themeMock = ThemeGeneratedMock()
        themeMock.underlyingTypography = themeTypographyMock
        themeMock.underlyingBorder = themeBorderMock
        themeMock.underlyingLayout = themeLayoutMock

        let intentColorMock: TagIntentColor = .alert
        let variantMock: TagVariant = .filled
        let iconImageMock = Image(systemName: "square.and.arrow.up")
        let textMock = "Text"

        let getColorsUseCaseMock = TagGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReturnValue = tagColorsMock

        // WHEN
        let viewModel = TagViewModel(
            theme: themeMock,
            intentColor: intentColorMock,
            variant: variantMock,
            iconImage: iconImageMock,
            text: textMock,
            getColorsUseCase: getColorsUseCaseMock
        )

        // THEN
        XCTAssertIdentical(viewModel.colors as? TagColorablesGeneratedMock,
                           tagColorsMock,
                           "Wrong colors value")
        XCTAssertIdentical(viewModel.typography as? TypographyGeneratedMock,
                           themeTypographyMock,
                           "Wrong typography value")
        XCTAssertIdentical(viewModel.spacing as? LayoutSpacingGeneratedMock,
                           themeSpacingMock,
                           "Wrong spacing value")
        XCTAssertIdentical(viewModel.border as? BorderGeneratedMock,
                           themeBorderMock,
                           "Wrong border value")
        XCTAssertEqual(viewModel.iconImage,
                       iconImageMock,
                       "Wrong iconImage value")
        XCTAssertEqual(viewModel.text,
                       textMock,
                       "Wrong text value")

        // **
        // GetDynamicContentSizeUseCase
        let getColorsUseCaseArgs = getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReceivedArguments
        XCTAssertEqual(getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount,
                       1,
                       "Wrong call number on execute on getColorsUseCase")
        
        XCTAssertIdentical(getColorsUseCaseArgs?.theme as? ThemeGeneratedMock,
                       themeMock,
                       "Wrong theme parameter on execute on getDynamicContentSizeUseCase")
        XCTAssertEqual(getColorsUseCaseArgs?.intentColor,
                       intentColorMock,
                       "Wrong intentColor parameter on execute on getDynamicContentSizeUseCase")
        XCTAssertEqual(getColorsUseCaseArgs?.variant,
                       variantMock,
                       "Wrong variant parameter on execute on getDynamicContentSizeUseCase")
        // **
    }
}
