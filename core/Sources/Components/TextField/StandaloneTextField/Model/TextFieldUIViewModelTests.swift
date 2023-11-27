//
//  TextFieldUIViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by Jacklyn Situmorang on 18.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class TextFieldUIViewModelTests: XCTestCase {

    // MARK: - Properties

    var theme: ThemeGeneratedMock!
    var getBordersUseCase: TextFieldGetBordersUseCasableGeneratedMock!
    var getColorsUseCase: TextFieldGetColorsUseCasableGeneratedMock!
    var getSpacingsUseCase: TextFieldGetSpacingsUseCasableGeneratedMock!
    var textFieldColors: TextFieldColors!
    var textFieldBorders: TextFieldBorders!
    var textFieldSpacings: TextFieldSpacings!
    var cancellables: Set<AnyCancellable>!
    var sut: TextFieldUIViewModel!

    // MARK: - Setup

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
        self.getBordersUseCase = TextFieldGetBordersUseCasableGeneratedMock()
        self.getColorsUseCase = TextFieldGetColorsUseCasableGeneratedMock()
        self.getSpacingsUseCase = TextFieldGetSpacingsUseCasableGeneratedMock()
        self.textFieldColors = TextFieldColors(border: .mock(ColorTokenGeneratedMock.random().color))
        self.textFieldBorders = TextFieldBorders(radius: .zero, width: .zero, widthWhenActive: .zero)
        self.textFieldSpacings = TextFieldSpacings(left: .zero, content: .zero, right: .zero)

        self.getColorsUseCase.executeWithThemeAndIntentReturnValue = self.textFieldColors
        self.getBordersUseCase.executeWithThemeAndBorderStyleReturnValue = self.textFieldBorders
        self.getSpacingsUseCase.executeWithThemeAndBorderStyleReturnValue = self.textFieldSpacings
        
        self.cancellables = .init()
        self.sut = .init(
            theme: self.theme,
            borderStyle: .none,
            getColorsUseCase: self.getColorsUseCase,
            getBordersUseCase: self.getBordersUseCase,
            getSpacingsUseCase: self.getSpacingsUseCase
        )
    }

    // MARK: - Tests

    func test_init() {
        for intent in TextFieldIntent.allCases {
            for borderStyle in TextFieldBorderStyle.allCases {
                // GIVEN
                self.getColorsUseCase.executeWithThemeAndIntentCallsCount = 0
                self.sut = TextFieldUIViewModel(
                    theme: self.theme,
                    intent: intent,
                    borderStyle: borderStyle,
                    getColorsUseCase: self.getColorsUseCase,
                    getBordersUseCase: self.getBordersUseCase,
                    getSpacingsUseCase: self.getSpacingsUseCase
                )

                // THEN
                XCTAssertIdentical(
                    self.sut.theme as? ThemeGeneratedMock,
                    self.theme,
                    "Textfield theme doesn't match expected theme"
                )

                XCTAssertEqual(
                    self.sut.intent,
                    intent,
                    "Textfield intent doesn't match expected intent"
                )

                XCTAssertEqual(
                    self.sut.borderStyle,
                    borderStyle,
                    "Textfield border style doesn't match expected border style"
                )

                self.testGetColorUseCaseExecute(
                    givenIntent: intent,
                    expectedCallCount: 1
                )
            }
        }
    }

    func test_set_theme() throws {
        // GIVEN
        self.getColorsUseCase.executeWithThemeAndIntentCallsCount = 0
        let newTheme = ThemeGeneratedMock.mocked()

        self.sut.setTheme(newTheme)
        self.theme = newTheme

        // THEN
        XCTAssertIdentical(
            self.sut.theme as? ThemeGeneratedMock,
            newTheme,
            "Theme is not updated"
        )

        self.testGetColorUseCaseExecute(givenIntent: .neutral, expectedCallCount: 1)
    }

    func test_set_intent() throws {
        for intent in TextFieldIntent.allCases {
            // GIVEN
            self.sut = TextFieldUIViewModel(
                theme: self.theme,
                intent: intent,
                borderStyle: .roundedRect,
                getColorsUseCase: self.getColorsUseCase
            )

            self.getColorsUseCase.executeWithThemeAndIntentCallsCount = 0

            // THEN

            XCTAssertEqual(
                self.sut.intent,
                intent,
                "Textfield intent doesn't match given intent"
            )
            self.testGetColorUseCaseExecute(expectedCallCount: 0)

            let newIntent = self.randomizeIntentAndRemoveCurrent(intent)
            self.sut.setIntent(newIntent)

            XCTAssertEqual(
                self.sut.intent,
                newIntent,
                "Textfield intent doesn't match updated intent"
            )
            self.testGetColorUseCaseExecute(givenIntent: newIntent, expectedCallCount: 1)
        }
    }

    func test_set_borderStyle() throws {
        // GIVEN
        self.getBordersUseCase.executeWithThemeAndBorderStyleCallsCount = 0
        let newBorderStyle = TextFieldBorderStyle.roundedRect

        self.sut.setBorderStyle(newBorderStyle)

        // THEN
        XCTAssertEqual(
            self.sut.borderStyle,
            newBorderStyle,
            "Border style is not updated"
        )
    }

    func test_colors_subscription_on_intent_change() throws {
        // GIVEN
        let expectation = expectation(description: "Colors updated on intent change")
        expectation.expectedFulfillmentCount = 1
        self.sut = TextFieldUIViewModel(
            theme: self.theme,
            intent: .neutral,
            borderStyle: .none,
            getColorsUseCase: self.getColorsUseCase
        )

        self.sut.$colors.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.setIntent(.error)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    func test_borders_subscription_on_borderStyle_change() {
        // GIVEN
        let expectation = expectation(description: "Colors updated on intent change")
        expectation.expectedFulfillmentCount = 1
        self.sut = TextFieldUIViewModel(
            theme: self.theme,
            borderStyle: .none,
            getBordersUseCase: self.getBordersUseCase
        )

        self.sut.$borders.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.setBorderStyle(.roundedRect)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    func test_spacings_subscription_on_borderSytle_change() {
        // GIVEN
        let expectation = expectation(description: "Colors updated on intent change")
        expectation.expectedFulfillmentCount = 1
        self.sut = TextFieldUIViewModel(
            theme: self.theme,
            borderStyle: .none,
            getSpacingsUseCase: self.getSpacingsUseCase
        )

        self.sut.$spacings.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.setBorderStyle(.roundedRect)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    private func testGetColorUseCaseExecute(
        givenIntent: TextFieldIntent? = nil,
        expectedCallCount: Int
    ) {
        XCTAssertEqual(
            self.getColorsUseCase.executeWithThemeAndIntentCallsCount,
            expectedCallCount,
            "Wrong call count on getColorUseCase execute"
        )

        if expectedCallCount > 0 {
            let args = self.getColorsUseCase.executeWithThemeAndIntentReceivedArguments

            XCTAssertEqual(
                args?.intent,
                givenIntent,
                "Wrong intent parameter on execute on getColorUseCase"
            )

            XCTAssertIdentical(
                args?.theme as? ThemeGeneratedMock,
                self.theme,
                "Wrong theme parameter on execute on getColorUseCase"
            )
        }
    }

    private func randomizeIntentAndRemoveCurrent(_ currentIntent: TextFieldIntent) -> TextFieldIntent {
        let filteredIntents = TextFieldIntent.allCases.filter({ $0 != currentIntent })
        let randomIndex = Int.random(in: 0...filteredIntents.count - 1)

        return filteredIntents[randomIndex]
    }
}
