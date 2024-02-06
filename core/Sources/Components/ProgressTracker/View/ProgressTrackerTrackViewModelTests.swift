//
//  ProgressTrackerTrackViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 06.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class ProgressTrackerTrackViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var useCase: ProgressTrackerGetTrackColorUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.useCase = ProgressTrackerGetTrackColorUseCaseableGeneratedMock()

        self.useCase.executeWithThemeAndIntentAndIsEnabledReturnValue = ColorTokenGeneratedMock.random()
    }

    func test_theme_updates_line_color_updates() {
        // GIVEN
        let sut = self.sut()
        let expect = expectation(description: "Expect line color to have been published")

        // WHEN
        sut.theme = ThemeGeneratedMock.mocked()

        sut.$lineColor.subscribe(in: &self.cancellables) { color in
            XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledReturnValue.uiColor, color.uiColor, "Expected color to have only been set once")
            expect.fulfill()
        }

        // THEN
        wait(for: [expect], timeout: 1)
        XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 2, "Expected use case to have been executed twice")
        
        let arguments = self.useCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertNotIdentical(arguments?.theme as? ThemeGeneratedMock, self.theme, "Expected theme to have changed")
    }

    func test_intent_updates_line_color_updates() {
        // GIVEN
        let sut = self.sut(intent: .basic)

        // WHEN
        sut.intent = .main

        // THEN
        XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 2, "Expected use case to have been called twice")

        let arguments = self.useCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(arguments?.intent, .main, "Expected argument of use case to be main")
    }

    func test_is_enabled_updates_line_color_updates() {
        // GIVEN
        let sut = self.sut(isEnabled: true)

        // WHEN
        sut.isEnabled = false

        // THEN
        XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 2, "Expected use case to have been called twice")

        let arguments = self.useCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(arguments?.isEnabled, false, "Expected isEnabled argument of use case to be false")
    }

    func test_intent_the_same_no_color_updates() {
        // GIVEN
        let sut = self.sut(intent: .basic)

        // WHEN
        sut.intent = .basic

        // THEN
        XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 1, "Expected use case to only have been called once")

        let arguments = self.useCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(arguments?.intent, .basic, "Expected argument of use case to be basic")
    }

    func test_is_enabled_not_updated_no_line_color_updates() {
        // GIVEN
        let sut = self.sut(isEnabled: true)

        // WHEN
        sut.isEnabled = true

        // THEN
        XCTAssertEqual(self.useCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 1, "Only expected use case to have been called once")

        let arguments = self.useCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(arguments?.isEnabled, true, "Argument of use case expected to be true")
    }

    func test_theme_produces_different_line_color() {

        // GIVEN
        let colors = [UIColor.red, .blue]
        self.useCase.executeWithThemeAndIntentAndIsEnabledReturnValue = ColorTokenGeneratedMock.init(uiColor: colors[0])
        let sut = self.sut()

        let expect = expectation(description: "Expect line color to have been published")
        expect.expectedFulfillmentCount = 2

        // WHEN
        var calls = 0
        sut.$lineColor.subscribe(in: &self.cancellables) { color in
            XCTAssertEqual(color.uiColor, colors[calls], "Expected color to be \(calls == 0 ? "red" : "blue")")
            expect.fulfill()
            calls += 1
        }

        self.useCase.executeWithThemeAndIntentAndIsEnabledReturnValue = ColorTokenGeneratedMock.init(uiColor: colors[1])
        sut.theme = ThemeGeneratedMock.mocked()

        // THEN
        wait(for: [expect], timeout: 1)
    }


    private func sut(
        intent: ProgressTrackerIntent = .basic,
        isEnabled: Bool = true) -> ProgressTrackerTrackViewModel {
        return .init(
            theme: self.theme,
            intent: intent,
            isEnabled: isEnabled,
            useCase: self.useCase
        )
    }
}
