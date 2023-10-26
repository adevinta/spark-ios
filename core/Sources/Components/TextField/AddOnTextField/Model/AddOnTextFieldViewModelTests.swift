//
//  AddOnTextFieldViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by Jacklyn Situmorang on 18.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class AddOnTextFieldViewModelTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!
    var getColorUseCase: TextFieldGetColorsUseCasableGeneratedMock!
    var borderColorToken: ColorTokenGeneratedMock!
    var cancellables: Set<AnyCancellable>!
    var sut: AddOnTextFieldViewModel!

    // MARK: - Setup

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
        self.getColorUseCase = TextFieldGetColorsUseCasableGeneratedMock()

        self.borderColorToken = ColorTokenGeneratedMock.random()
        self.getColorUseCase.executeWithThemeAndIntentReturnValue = TextFieldColors(border: borderColorToken)

        self.cancellables = .init()
        self.sut = .init(
            theme: self.theme,
            intent: .alert,
            getColorUseCase: self.getColorUseCase
        )
    }

    // MARK: - Tests

    func test_init() {
        for intent in TextFieldIntent.allCases {
            // GIVEN
            self.getColorUseCase.executeWithThemeAndIntentCallsCount = 0
            self.sut = AddOnTextFieldViewModel(
                theme: self.theme,
                intent: intent,
                getColorUseCase: self.getColorUseCase
            )

            // THEN
            XCTAssertIdentical(
                self.sut.theme as? ThemeGeneratedMock,
                self.theme,
                "Add-on text field theme doesn't match expected theme"
            )

            XCTAssertEqual(
                self.sut.intent,
                intent,
                "Add-on text field intent doesn't match expected intent"
            )

            XCTAssertIdentical(
                self.sut.textFieldColors.border as? ColorTokenGeneratedMock,
                self.borderColorToken,
                "Add-on text field border color doesn't match given color"
            )

            self.testGetColorUseCaseExecute(
                givenIntent: intent,
                expectedCallCount: 1
            )
        }
    }

    func test_set_theme() throws {
        // GIVEN
        self.getColorUseCase.executeWithThemeAndIntentCallsCount = 0
        let newTheme = ThemeGeneratedMock.mocked()

        self.sut.setTheme(newTheme)
        self.theme = newTheme

        // THEN
        XCTAssertIdentical(
            self.sut.theme as? ThemeGeneratedMock,
            newTheme,
            "Theme is not updated"
        )

        self.testGetColorUseCaseExecute(givenIntent: .alert, expectedCallCount: 1)
    }

    func test_set_intent() throws {
        for intent in TextFieldIntent.allCases {
            // GIVEN
            self.sut = AddOnTextFieldViewModel(
                theme: self.theme,
                intent: intent,
                getColorUseCase: self.getColorUseCase
            )

            self.getColorUseCase.executeWithThemeAndIntentCallsCount = 0

            // THEN

            XCTAssertEqual(
                self.sut.intent,
                intent,
                "Add-on text field intent doesn't match given intent"
            )
            self.testGetColorUseCaseExecute(expectedCallCount: 0)

            let newIntent = self.randomizeIntentAndRemoveCurrent(intent)
            self.sut.setIntent(newIntent)

            XCTAssertEqual(
                self.sut.intent,
                newIntent,
                "Add-on text field intent doesn't match the initial given intent"
            )
            self.testGetColorUseCaseExecute(
                givenIntent: newIntent,
                expectedCallCount: 1)
        }

    }

    func test_color_subscription_on_intent_change() throws {
        // GIVEN
        let expectation = expectation(description: "Color updated on intent change")
        expectation.expectedFulfillmentCount = 1
        self.sut = AddOnTextFieldViewModel(
            theme: self.theme,
            intent: .alert,
            getColorUseCase: self.getColorUseCase
        )

        self.sut.$textFieldColors.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.setIntent(.error)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    private func testGetColorUseCaseExecute(
        givenIntent: TextFieldIntent? = nil,
        expectedCallCount: Int
    ) {
        XCTAssertEqual(
            self.getColorUseCase.executeWithThemeAndIntentCallsCount,
            expectedCallCount,
            "Wrong call count on getColorUseCase execute"
        )

        if expectedCallCount > 0 {
            let args = self.getColorUseCase.executeWithThemeAndIntentReceivedArguments

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
