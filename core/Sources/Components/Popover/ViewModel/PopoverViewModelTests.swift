//
//  PopoverViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 26/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class PopoverViewModelTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_init() throws {
        // GIVEN
        let getColorsUseCaseMock = PopoverGetColorsUseCasableGeneratedMock()
        getColorsUseCaseMock.executeWithColorsAndIntentReturnValue = .init(
            background: self.theme.colors.feedback.alertContainer,
            foreground: self.theme.colors.basic.basicContainer
        )

        let getSpacesUseCaseMock = PopoverGetSpacesUseCasableGeneratedMock()
        getSpacesUseCaseMock.executeWithLayoutSpacingReturnValue = .init(
            horizontal: 4,
            vertical: 2
        )

        // WHEN
        let viewModel = PopoverViewModel(
            theme: self.theme,
            intent: .basic,
            showArrow: true,
            getColorsUseCase: getColorsUseCaseMock,
            getSpacesUseCase: getSpacesUseCaseMock
        )

        // THEN - Values
        XCTAssertTrue(viewModel.colors.background.equals(self.theme.colors.feedback.alertContainer), "Wrong colors.background")
        XCTAssertTrue(viewModel.colors.foreground.equals(self.theme.colors.basic.basicContainer), "Wrong colors.foreground")

        XCTAssertEqual(viewModel.spaces.horizontal, 4.0, "Wrong spaces.horizontal")
        XCTAssertEqual(viewModel.spaces.vertical, 2.0, "Wrong spaces.vertical")

        XCTAssertTrue(viewModel.showArrow, "showArrow should be true")

        XCTAssertEqual(viewModel.arrowSize, self.theme.layout.spacing.medium, "Wrong arrowSize")

        // THEN - GetColorsUseCase
        XCTAssertEqual(getColorsUseCaseMock.executeWithColorsAndIntentCallsCount, 1, "getColorsUseCaseMock.executeWithColorsAndIntent should have been called once")
        let getColorsUseCaseReceivedArguments = try XCTUnwrap(getColorsUseCaseMock.executeWithColorsAndIntentReceivedArguments, "Couldn't unwrap getColorsUseCaseMock.executeWithColorsAndIntentRe")
        XCTAssertIdentical(
            getColorsUseCaseReceivedArguments.colors as? ColorsGeneratedMock,
            self.theme.colors as? ColorsGeneratedMock,
            "Wrong getColorsUseCaseReceivedArguments.colors"
        )
        XCTAssertEqual(getColorsUseCaseReceivedArguments.intent, .basic, "Wrong getColorsUseCaseReceivedArguments.intent")

        // THEN - GetSpacesUseCase
        XCTAssertEqual(getSpacesUseCaseMock.executeWithLayoutSpacingCallsCount, 1, "getSpacesUseCaseMock.executeWithLayoutSpacing should have been called once")
        let getSpacesUseCaseReceivedLayoutSpacing = try XCTUnwrap(getSpacesUseCaseMock.executeWithLayoutSpacingReceivedLayoutSpacing, "Couldn't unwrap getSpacesUseCaseMock.executeWithLayoutSpacingReceivedLayoutSpacing")
        XCTAssertIdentical(
            getSpacesUseCaseReceivedLayoutSpacing as? LayoutSpacingGeneratedMock,
            self.theme.layout.spacing as? LayoutSpacingGeneratedMock,
            "Wrong getSpacesUseCaseReceivedLayoutSpacing"
        )
    }
}
