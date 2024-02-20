//
//  TextFieldViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import Combine
import UIKit
import SwiftUI
@testable import SparkCore

final class TextFieldViewModelTests: XCTestCase {

    private var theme: ThemeGeneratedMock!
    private var publishers: TextFieldPublishers!
    private var getColorsUseCase: TextFieldGetColorsUseCasableGeneratedMock!
    private var getBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasableGeneratedMock!
    private var getSpacingsUseCase: TextFieldGetSpacingsUseCasableGeneratedMock!
    private var viewModel: TextFieldViewModel!

    private let intent = TextFieldIntent.success
    private let borderStyle = TextFieldBorderStyle.roundedRect

    private var expectedColors: TextFieldColors!
    private var expectedBorderLayout: TextFieldBorderLayout!
    private var expectedSpacings: TextFieldSpacings!

    private let successImage = UIImage(systemName: "square.and.arrow.up.fill")!
    private let alertImage = Image(systemName: "rectangle.portrait.and.arrow.right.fill")
    private let errorImage = UIImage(systemName: "eraser.fill")!

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()

        self.expectedColors = .mocked(
            text: .blue(),
            placeholder: .green(),
            border: .yellow(),
            statusIcon: .red(),
            background: .purple()
        )
        self.expectedBorderLayout = .mocked(radius: 1, width: 2)
        self.expectedSpacings = .mocked(left: 1, content: 2, right: 3)

        self.getColorsUseCase = .mocked(returnedColors: self.expectedColors)
        self.getBorderLayoutUseCase = .mocked(returnedBorderLayout: self.expectedBorderLayout)
        self.getSpacingsUseCase = .mocked(returnedSpacings: self.expectedSpacings)
        self.viewModel = .init(
            theme: self.theme,
            intent: self.intent,
            borderStyle: self.borderStyle,
            successImage: .left(self.successImage),
            alertImage: .right(self.alertImage),
            errorImage: .left(self.errorImage),
            getColorsUseCase: self.getColorsUseCase,
            getBorderLayoutUseCase: self.getBorderLayoutUseCase,
            getSpacingsUseCase: self.getSpacingsUseCase
        )

        self.setupPublishers()
    }

    // MARK: - init
    func test_init() throws {
        // GIVEN / WHEN - Inits from setUp()
        // THEN - Simple variables
        XCTAssertIdentical(self.viewModel.theme as? ThemeGeneratedMock, self.theme, "Wrong theme")
        XCTAssertEqual(self.viewModel.intent, self.intent, "Wrong intent")
        XCTAssertEqual(self.viewModel.borderStyle, self.borderStyle, "Wrong borderStyle")
        XCTAssertTrue(self.viewModel.isEnabled, "Wrong isEnabled")
        XCTAssertTrue(self.viewModel.isUserInteractionEnabled, "Wrong isUserInteractionEnabled")
        XCTAssertFalse(self.viewModel.isFocused, "Wrong isFocused")
        XCTAssertEqual(self.viewModel.successImage, .left(self.successImage), "Wrong successImage")
        XCTAssertEqual(self.viewModel.alertImage, .right(self.alertImage), "Wrong alertImage")
        XCTAssertEqual(self.viewModel.errorImage, .left(self.errorImage), "Wrong errorImage")
        XCTAssertEqual(self.viewModel.dim, self.theme.dims.none, "Wrong dim")
        XCTAssertEqual(self.viewModel.statusImage, .left(self.successImage), "Wrong statusImage")
        XCTAssertIdentical(self.viewModel.font as? TypographyFontTokenGeneratedMock, self.theme.typography.body1 as? TypographyFontTokenGeneratedMock, "Wrong font")

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertFalse(getColorsReceivedArguments.isFocused, "Wrong getColorsReceivedArguments.isFocused")
        XCTAssertTrue(getColorsReceivedArguments.isEnabled, "Wrong getColorsReceivedArguments.isEnabled")
        XCTAssertTrue(getColorsReceivedArguments.isUserInteractionEnabled, "Wrong getColorsReceivedArguments.isUserInteractionEnabled")
        XCTAssertTrue(self.viewModel.textColor.equals(self.expectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(self.expectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(self.expectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(self.expectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(self.expectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertIdentical(getBorderLayoutReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getBorderLayoutReceivedArguments.theme")
        XCTAssertEqual(getBorderLayoutReceivedArguments.borderStyle, .roundedRect, "Wrong getBorderLayoutReceivedArguments.borderStyle")
        XCTAssertFalse(getBorderLayoutReceivedArguments.isFocused, "Wrong getBorderLayoutReceivedArguments.isFocused")
        XCTAssertEqual(self.viewModel.borderWidth, self.expectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, self.expectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertEqual(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 1, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called once")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertIdentical(getSpacingsUseCaseReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getSpacingsUseCaseReceivedArguments.theme")
        XCTAssertEqual(getSpacingsUseCaseReceivedArguments.borderStyle, .roundedRect, "Wrong getSpacingsUseCaseReceivedArguments.borderStyle")
        XCTAssertEqual(self.viewModel.leftSpacing, self.expectedSpacings.left, "Wrong leftSpacing")
        XCTAssertEqual(self.viewModel.contentSpacing, self.expectedSpacings.content, "Wrong contentSpacing")
        XCTAssertEqual(self.viewModel.rightSpacing, self.expectedSpacings.right, "Wrong rightSpacing")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "$borderWidth should have been called once")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "$borderRadius should have been called once")

        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "$leftSpacing should have been called once")
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "$contentSpacing should have been called once")
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "$rightSpacing should have been called once")

        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
        XCTAssertEqual(self.publishers.font.sinkCount, 1, "$font should have been called once")
        XCTAssertEqual(self.publishers.statusImage.sinkCount, 1, "$statusImage should have been called once")
    }

    // MARK: Theme
    func test_theme_didSet() throws {
        // GIVEN - Inits from setUp()
        let newTheme = ThemeGeneratedMock()
        newTheme.typography = TypographyGeneratedMock.mocked()
        newTheme.dims = DimsGeneratedMock.mocked()

        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedColors = TextFieldColors.mocked(
            text: .red(),
            placeholder: .blue(),
            border: .green(),
            statusIcon: .purple(),
            background: .red()
        )
        self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = newExpectedColors

        let newExpectedBorderLayout = TextFieldBorderLayout.mocked(radius: 20.0, width: 100.0)
        self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReturnValue = newExpectedBorderLayout

        let newExpectedSpacings = TextFieldSpacings.mocked(left: 10, content: 20, right: 30)
        self.getSpacingsUseCase.executeWithThemeAndBorderStyleReturnValue = newExpectedSpacings

        // WHEN
        self.viewModel.theme = newTheme

        // THEN - Theme
        XCTAssertIdentical(self.viewModel.theme as? ThemeGeneratedMock, newTheme, "Wrong theme")

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, newTheme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertTrue(self.viewModel.textColor.equals(newExpectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(newExpectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(newExpectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(newExpectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newExpectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertIdentical(getBorderLayoutReceivedArguments.theme as? ThemeGeneratedMock, newTheme, "Wrong getBorderLayoutReceivedArguments.theme")
        XCTAssertEqual(self.viewModel.borderWidth, newExpectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, newExpectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertEqual(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 1, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called once")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertIdentical(getSpacingsUseCaseReceivedArguments.theme as? ThemeGeneratedMock, newTheme, "Wrong getSpacingsUseCaseReceivedArguments.theme")
        XCTAssertEqual(self.viewModel.leftSpacing, newExpectedSpacings.left, "Wrong leftSpacing")
        XCTAssertEqual(self.viewModel.contentSpacing, newExpectedSpacings.content, "Wrong contentSpacing")
        XCTAssertEqual(self.viewModel.rightSpacing, newExpectedSpacings.right, "Wrong rightSpacing")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "$borderWidth should have been called once")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "$borderRadius should have been called once")

        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "$leftSpacing should have been called once")
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "$contentSpacing should have been called once")
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "$rightSpacing should have been called once")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertEqual(self.publishers.font.sinkCount, 1, "$font should have been called once")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    // MARK: - Intent
    func test_intent_didSet_equal() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.intent = self.intent

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_intent_didSet_notEqual_samePublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.intent = .error

        // THEN
        XCTAssertEqual(self.viewModel.statusImage, .left(self.errorImage), "Wrong statusImage")

        // Then - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertEqual(getColorsReceivedArguments.intent, .error, "Wrong getColorsReceivedArguments.intent")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertEqual(self.publishers.statusImage.sinkCount, 1, "$statusImage should have been called once")
    }

    func test_intent_didSet_notEqual_differentPublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.viewModel.intent = .alert
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedColors = TextFieldColors.mocked(
            text: .red(),
            placeholder: .blue(),
            border: .green(),
            statusIcon: .purple(),
            background: .red()
        )
        self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = newExpectedColors

        // WHEN
        self.viewModel.intent = .neutral

        // THEN
        XCTAssertNil(self.viewModel.statusImage, "Wrong statusImage")

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertEqual(getColorsReceivedArguments.intent , .neutral, "Wrong getColorsReceivedArguments.intent")
        XCTAssertTrue(self.viewModel.textColor.equals(newExpectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(newExpectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(newExpectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(newExpectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newExpectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertEqual(self.publishers.statusImage.sinkCount, 1,"$statusImage should have been called once")
    }

    // MARK: - Border Style
    func test_borderStyle_didSet_equal() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.borderStyle = self.borderStyle

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_borderStyle_didSet_notEqual_samePublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.borderStyle = .none

        // Then - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertEqual(getBorderLayoutReceivedArguments.borderStyle, .none, "Wrong getBorderLayoutReceivedArguments.borderStyle")

        // THEN - Spacings
        XCTAssertEqual(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 1, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called once")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertEqual(getSpacingsUseCaseReceivedArguments.borderStyle, .none, "Wrong getSpacingsUseCaseReceivedArguments.borderStyle")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_borderStyle_didSet_notEqual_differentPublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedBorderLayout = TextFieldBorderLayout.mocked(radius: 20.0, width: 100.0)
        self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReturnValue = newExpectedBorderLayout

        let newExpectedSpacings = TextFieldSpacings.mocked(left: 10, content: 20, right: 30)
        self.getSpacingsUseCase.executeWithThemeAndBorderStyleReturnValue = newExpectedSpacings

        // WHEN
        self.viewModel.borderStyle = .none

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertEqual(getBorderLayoutReceivedArguments.borderStyle, .none, "Wrong getBorderLayoutReceivedArguments.borderStyle")
        XCTAssertEqual(self.viewModel.borderWidth, newExpectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, newExpectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertEqual(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 1, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called once")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertEqual(getSpacingsUseCaseReceivedArguments.borderStyle, .none, "Wrong getSpacingsUseCaseReceivedArguments.borderStyle")
        XCTAssertEqual(self.viewModel.leftSpacing, newExpectedSpacings.left, "Wrong leftSpacing")
        XCTAssertEqual(self.viewModel.contentSpacing, newExpectedSpacings.content, "Wrong contentSpacing")
        XCTAssertEqual(self.viewModel.rightSpacing, newExpectedSpacings.right, "Wrong rightSpacing")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "$borderWidth should have been called once")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "$borderRadius should have been called once")

        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "$leftSpacing should have been called once")
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "$contentSpacing should have been called once")
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "$rightSpacing should have been called once")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled,"$statusImage should npt have been called")
    }

    // MARK: - Is Focused
    func test_isFocused_didSet_equal() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isFocused = false

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_isFocused_didSet_notEqual_samePublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isFocused = true

        // Then - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertTrue(getColorsReceivedArguments.isFocused, "Wrong getColorsReceivedArguments.isFocused")
        XCTAssertTrue(self.viewModel.textColor.equals(self.expectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(self.expectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(self.expectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(self.expectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(self.expectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertTrue(getBorderLayoutReceivedArguments.isFocused, "Wrong getBorderLayoutReceivedArguments.isFocused")
        XCTAssertEqual(self.viewModel.borderWidth, self.expectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, self.expectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_isFocused_didSet_notEqual_differentPublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedColors = TextFieldColors.mocked(
            text: .red(),
            placeholder: .blue(),
            border: .green(),
            statusIcon: .purple(),
            background: .red()
        )
        self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = newExpectedColors

        let newExpectedBorderLayout = TextFieldBorderLayout.mocked(radius: 20.0, width: 100.0)
        self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReturnValue = newExpectedBorderLayout

        // WHEN
        self.viewModel.isFocused = true

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertTrue(getColorsReceivedArguments.isFocused, "Wrong getColorsReceivedArguments.isFocused")
        XCTAssertTrue(self.viewModel.textColor.equals(newExpectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(newExpectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(newExpectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(newExpectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newExpectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertTrue(getBorderLayoutReceivedArguments.isFocused, "Wrong getBorderLayoutReceivedArguments.isFocused")
        XCTAssertEqual(self.viewModel.borderWidth, newExpectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, newExpectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "$borderWidth should have been called once")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "$borderRadius should have been called once")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should have not been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should have not been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should have not been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled,"$statusImage should npt have been called")
    }

    // MARK: - Is Enabled
    func test_isEnabled_didSet_equal() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isEnabled = true

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_isEnabled_didSet_notEqual_samePublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.viewModel.intent = .neutral
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isEnabled = false

        XCTAssertNil(self.viewModel.statusImage, "statusImage should be nil when isEnabled is false")
        // Then - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, .neutral, "Wrong getColorsReceivedArguments.intent")
        XCTAssertFalse(getColorsReceivedArguments.isEnabled, "Wrong getColorsReceivedArguments.isEnabled")
        XCTAssertTrue(self.viewModel.textColor.equals(self.expectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(self.expectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(self.expectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(self.expectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(self.expectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled,"$statusImage should not have been called")
    }

    func test_isEnabled_didSet_notEqual_differentPublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.viewModel.isEnabled = false
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedColors = TextFieldColors.mocked(
            text: .red(),
            placeholder: .blue(),
            border: .green(),
            statusIcon: .purple(),
            background: .red()
        )
        self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = newExpectedColors

        // WHEN
        self.viewModel.isEnabled = true

        XCTAssertEqual(self.viewModel.statusImage, .left(self.successImage), "Wrong statusImage")
        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertTrue(getColorsReceivedArguments.isEnabled, "Wrong getColorsReceivedArguments.isEnabledd")
        XCTAssertTrue(self.viewModel.textColor.equals(newExpectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(newExpectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(newExpectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(newExpectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newExpectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should have not been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should have not been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should have not been called")

        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertEqual(self.publishers.statusImage.sinkCount, 1,"$statusImage should have been called once")
    }

    // MARK: - Is User Interaction Enabled
    func test_isUserInteractionEnabled_didSet_equal() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isUserInteractionEnabled = true

        // THEN - Colors
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCalled, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should not have been called")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_isUserInteractionEnabled_didSet_notEqual_samePublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isUserInteractionEnabled = false

        // Then - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertFalse(getColorsReceivedArguments.isUserInteractionEnabled, "Wrong getColorsReceivedArguments.isUserInteractionEnabled")
        XCTAssertTrue(self.viewModel.textColor.equals(self.expectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(self.expectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(self.expectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(self.expectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(self.expectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.textColor.sinkCalled, "$textColor should not have been called")
        XCTAssertFalse(self.publishers.borderColor.sinkCalled, "$borderColorIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled, "$backgroundColor should not have been called")
        XCTAssertFalse(self.publishers.placeholderColor.sinkCalled, "$placeholderColor should not have been called")
        XCTAssertFalse(self.publishers.statusIconColor.sinkCalled, "$statusIconColor should not have been called")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled, "$statusImage should not have been called")
    }

    func test_isUserInteractionEnabled_didSet_notEqual_differentPublishedValues() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        let newExpectedColors = TextFieldColors.mocked(
            text: .red(),
            placeholder: .blue(),
            border: .green(),
            statusIcon: .purple(),
            background: .red()
        )
        self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = newExpectedColors

        // WHEN
        self.viewModel.isUserInteractionEnabled = false

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertFalse(getColorsReceivedArguments.isUserInteractionEnabled, "Wrong getColorsReceivedArguments.isUserInteractionEnabled")
        XCTAssertTrue(self.viewModel.textColor.equals(newExpectedColors.text), "Wrong textColor")
        XCTAssertTrue(self.viewModel.placeholderColor.equals(newExpectedColors.placeholder), "Wrong placeholderColor")
        XCTAssertTrue(self.viewModel.borderColor.equals(newExpectedColors.border), "Wrong borderColor")
        XCTAssertTrue(self.viewModel.statusIconColor.equals(newExpectedColors.statusIcon), "Wrong statusColor")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newExpectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertFalse(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCalled, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should not have been called")

        // THEN - Spacings
        XCTAssertFalse(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCalled, "getSpacingsUseCase.executeWithThemeAndBorderStyle should not have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.textColor.sinkCount, 1, "$textColor should have been called once")
        XCTAssertEqual(self.publishers.borderColor.sinkCount, 1, "$borderColorIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")
        XCTAssertEqual(self.publishers.placeholderColor.sinkCount, 1, "$placeholderColor should have been called once")
        XCTAssertEqual(self.publishers.statusIconColor.sinkCount, 1, "$statusIconColor should have been called once")

        XCTAssertFalse(self.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")

        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled, "$leftSpacing should have not been called")
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled, "$contentSpacing should have not been called")
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled, "$rightSpacing should have not been called")

        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.font.sinkCalled, "$font should not have been called")
        XCTAssertFalse(self.publishers.statusImage.sinkCalled,"$statusImage should npt have been called")
    }

    // MARK: - Utils
    private func setupPublishers() {
        self.publishers = .init(
            textColor: PublisherMock(publisher: self.viewModel.textColorSubject),
            placeholderColor: PublisherMock(publisher: self.viewModel.placeholderColorSubject),
            borderColor: PublisherMock(publisher: self.viewModel.borderColorSubject),
            statusIconColor: PublisherMock(publisher: self.viewModel.statusIconColorSubject),
            backgroundColor: PublisherMock(publisher: self.viewModel.backgroundColorSubject),
            borderRadius: PublisherMock(publisher: self.viewModel.borderRadiusSubject),
            borderWidth: PublisherMock(publisher: self.viewModel.borderWidthSubject),
            leftSpacing: PublisherMock(publisher: self.viewModel.leftSpacingSubject),
            contentSpacing: PublisherMock(publisher: self.viewModel.contentSpacingSubject),
            rightSpacing: PublisherMock(publisher: self.viewModel.rightSpacingSubject),
            dim: PublisherMock(publisher: self.viewModel.dimSubject),
            font: PublisherMock(publisher: self.viewModel.fontSubject),
            statusImage: PublisherMock(publisher: self.viewModel.statusImageSubject)
        )
        self.publishers.load()
    }

    private func resetUseCases() {
        self.getColorsUseCase.reset()
        self.getBorderLayoutUseCase.reset()
        self.getSpacingsUseCase.reset()
    }
}

final class TextFieldPublishers {
    var cancellables = Set<AnyCancellable>()

    var textColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>
    var placeholderColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>
    var borderColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>
    var statusIconColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>
    var backgroundColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>

    var borderRadius: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var borderWidth: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    var leftSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var contentSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var rightSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    var dim: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    var font: PublisherMock<CurrentValueSubject<any TypographyFontToken, Never>>

    var statusImage: PublisherMock<CurrentValueSubject<ImageEither?, Never>>

    init(
        textColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        placeholderColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        borderColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        statusIconColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        backgroundColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        borderRadius: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        borderWidth: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        leftSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        contentSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        rightSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        dim: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        font: PublisherMock<CurrentValueSubject<TypographyFontToken, Never>>,
        statusImage: PublisherMock<CurrentValueSubject<ImageEither?, Never>>
    ) {
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.borderColor = borderColor
        self.statusIconColor = statusIconColor
        self.backgroundColor = backgroundColor
        self.borderRadius = borderRadius
        self.borderWidth = borderWidth
        self.leftSpacing = leftSpacing
        self.contentSpacing = contentSpacing
        self.rightSpacing = rightSpacing
        self.dim = dim
        self.font = font
        self.statusImage = statusImage
    }

    func load() {
        self.cancellables = Set<AnyCancellable>()

        [self.textColor, self.placeholderColor, self.borderColor, self.statusIconColor, self.backgroundColor].forEach {
            $0.loadTesting(on: &self.cancellables)
        }

        [self.borderWidth, self.borderRadius, self.leftSpacing, self.contentSpacing, self.rightSpacing, self.dim].forEach {
            $0.loadTesting(on: &self.cancellables)
        }

        self.font.loadTesting(on: &self.cancellables)

        self.statusImage.loadTesting(on: &self.cancellables)
    }

    func reset() {
        [self.textColor, self.placeholderColor, self.borderColor, self.statusIconColor, self.backgroundColor].forEach {
            $0.reset()
        }

        [self.borderWidth, self.borderRadius, self.leftSpacing, self.contentSpacing, self.rightSpacing, self.dim].forEach {
            $0.reset()
        }

        self.font.reset()

        self.statusImage.reset()
    }
}
