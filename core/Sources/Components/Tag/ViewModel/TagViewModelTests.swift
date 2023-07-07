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

    // MARK: - Properties

    private let themeTypographyMock = TypographyGeneratedMock()
    private let themeBorderMock = BorderGeneratedMock()
    private let themeSpacingMock = LayoutSpacingGeneratedMock()
    private lazy var themeLayoutMock: LayoutGeneratedMock = {
        let mock = LayoutGeneratedMock()
        mock.underlyingSpacing = self.themeSpacingMock
        return mock
    }()
    private lazy var themeMock: ThemeGeneratedMock = {
        let mock = ThemeGeneratedMock()
        mock.underlyingTypography = self.themeTypographyMock
        mock.underlyingBorder = self.themeBorderMock
        mock.underlyingLayout = self.themeLayoutMock
        return mock
    }()

    private let tagColorsMock = TagColors.mocked()
    private lazy var getColorsUseCaseMock: TagGetColorsUseCaseableGeneratedMock = {
        let mock = TagGetColorsUseCaseableGeneratedMock()
        mock.executeWithThemeAndIntentColorAndVariantReturnValue = self.tagColorsMock
        return mock
    }()

    // MARK: - Properties Tests

    func test_default_properties() {
        // GIVEN / WHEN
        let viewModel = TagViewModel(
            theme: self.themeMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // THEN
        self.testProperties(
            on: viewModel,
            expectedIntentColor: .primary,
            expectedVariant: .filled,
            expectedIconImage: nil,
            expectedText: nil
        )
    }

    func test_properties() {
        // GIVEN / WHEN
        let intentColorMock: TagIntentColor = .alert
        let variantMock: TagVariant = .outlined
        let iconImageMock = Image(systemName: "square.and.arrow.up")
        let textMock = "Text"

        let viewModel = TagViewModel(
            theme: self.themeMock,
            intentColor: intentColorMock,
            variant: variantMock,
            iconImage: iconImageMock,
            text: textMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // THEN
        self.testProperties(
            on: viewModel,
            expectedIntentColor: intentColorMock,
            expectedVariant: variantMock,
            expectedIconImage: iconImageMock,
            expectedText: textMock
        )
    }

    func testProperties(
        on givenViewModel: TagViewModel,
        expectedIntentColor: TagIntentColor,
        expectedVariant: TagVariant,
        expectedIconImage: Image?,
        expectedText: String?
    ) {
        XCTAssertEqual(givenViewModel.colors,
                       self.tagColorsMock,
                       "Wrong colors value")
        XCTAssertIdentical(givenViewModel.typography as? TypographyGeneratedMock,
                           self.themeTypographyMock,
                           "Wrong typography value")
        XCTAssertIdentical(givenViewModel.spacing as? LayoutSpacingGeneratedMock,
                           self.themeSpacingMock,
                           "Wrong spacing value")
        XCTAssertIdentical(givenViewModel.border as? BorderGeneratedMock,
                           self.themeBorderMock,
                           "Wrong border value")
        XCTAssertEqual(givenViewModel.iconImage,
                       expectedIconImage,
                       "Wrong iconImage value")
        XCTAssertEqual(givenViewModel.text,
                       expectedText,
                       "Wrong text value")

        // **
        // GetColorsUseCase
        let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReceivedArguments
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount,
                       1,
                       "Wrong call number on execute on getColorsUseCase")

        XCTAssertIdentical(getColorsUseCaseArgs?.theme as? ThemeGeneratedMock,
                           themeMock,
                           "Wrong theme parameter on execute on getColorsUseCase")
        XCTAssertEqual(getColorsUseCaseArgs?.intentColor,
                       expectedIntentColor,
                       "Wrong intentColor parameter on execute on getColorsUseCase")
        XCTAssertEqual(getColorsUseCaseArgs?.variant,
                       expectedVariant,
                       "Wrong variant parameter on execute on getColorsUseCase")
        // **
    }

    // MARK: - Public Setter Tests

    func test_setIntentColor_should_update_colors() {
        // GIVEN
        let intentColorMock: TagIntentColor = .danger

        let newTagColorsMock = TagColors.mocked()

        self.getColorsUseCaseMock._executeWithThemeAndIntentColorAndVariant = { theme, intentColor, variant in
            if self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount == 0 {
                return self.tagColorsMock
            } else {
                return newTagColorsMock
            }
        }

        let viewModel = TagViewModel(
            theme: self.themeMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // WHEN
        viewModel.setIntentColor(intentColorMock)

        // THEN
        XCTAssertEqual(viewModel.colors,
                       newTagColorsMock,
                       "Wrong colors value")

        // **
        // GetColorsUseCase
        let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReceivedArguments
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount,
                       2,
                       "Wrong call number on execute on getColorsUseCase")

        XCTAssertEqual(getColorsUseCaseArgs?.intentColor,
                       intentColorMock,
                       "Wrong intentColor parameter on execute on getColorsUseCase")
        // **
    }

    func test_setVariant_should_update_colors() {
        // GIVEN
        let variantMock: TagVariant = .outlined

        let newTagColorsMock = TagColors.mocked()

        self.getColorsUseCaseMock._executeWithThemeAndIntentColorAndVariant = { theme, intentColor, variant in
            if self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount == 0 {
                return self.tagColorsMock
            } else {
                return newTagColorsMock
            }
        }

        let viewModel = TagViewModel(
            theme: self.themeMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // WHEN
        viewModel.setVariant(variantMock)

        // THEN
        XCTAssertEqual(viewModel.colors,
                       newTagColorsMock,
                       "Wrong colors value")

        // **
        // GetColorsUseCase
        let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReceivedArguments
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantCallsCount,
                       2,
                       "Wrong call number on execute on getColorsUseCase")

        XCTAssertEqual(getColorsUseCaseArgs?.variant,
                       variantMock,
                       "Wrong variant parameter on execute on getColorsUseCase")
        // **
    }

    func test_setIconImage() {
        // GIVEN
        let newIconImage = Image(systemName: "square.and.arrow.up.fill")

        let viewModel = TagViewModel(
            theme: self.themeMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // WHEN
        viewModel.setIconImage(newIconImage)

        // THEN
        XCTAssertEqual(viewModel.iconImage,
                       newIconImage,
                       "Wrong iconImage value")
    }

    func test_setText() {
        // GIVEN
        let newText = "New text"

        let viewModel = TagViewModel(
            theme: self.themeMock,
            getColorsUseCase: self.getColorsUseCaseMock
        )

        // WHEN
        viewModel.setText(newText)

        // THEN
        XCTAssertEqual(viewModel.text,
                       newText,
                       "Wrong text value")
    }
}
