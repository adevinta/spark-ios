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
@_spi(SI_SPI) import SparkCommon
import SparkThemingTesting

final class ProgressTrackerTrackViewModelTests: XCTestCase {

    var colors: ColorsGeneratedMock!
    var theme: ThemeGeneratedMock!
    var useCase: ProgressTrackerGetTrackColorUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        self.colors = ColorsGeneratedMock.mocked()
        self.theme = ThemeGeneratedMock.mocked()
        self.useCase = ProgressTrackerGetTrackColorUseCaseableGeneratedMock()

        self.useCase.executeWithColorsAndIntentReturnValue = ColorTokenGeneratedMock.random()
    }

    func test_theme_updates_line_color_updates() {
        // GIVEN
        let sut = self.sut()
        let expect = expectation(description: "Expect line color to have been published")

        // WHEN
        sut.theme = ThemeGeneratedMock.mocked()

        sut.$lineColor.subscribe(in: &self.cancellables) { color in
            XCTAssertEqual(self.useCase.executeWithColorsAndIntentReturnValue.uiColor, color.uiColor, "Expected color to have only been set once")
            expect.fulfill()
        }

        // THEN
        wait(for: [expect], timeout: 1)
        XCTAssertEqual(self.useCase.executeWithColorsAndIntentCallsCount, 2, "Expected use case to have been executed twice")

        let arguments = self.useCase.executeWithColorsAndIntentReceivedArguments

        XCTAssertNotIdentical(arguments?.colors as? ColorsGeneratedMock, self.colors, "Expected theme to have changed")
    }

    func test_intent_updates_line_color_updates() {
        // GIVEN
        let sut = self.sut(intent: .basic)

        // WHEN
        sut.intent = .main

        // THEN
        XCTAssertEqual(self.useCase.executeWithColorsAndIntentCallsCount, 2, "Expected use case to have been called twice")

        let arguments = self.useCase.executeWithColorsAndIntentReceivedArguments

        XCTAssertEqual(arguments?.intent, .main, "Expected argument of use case to be main")
    }

    func test_is_enabled_updates_opacity_updates() {
        // GIVEN
        let sut = self.sut(isEnabled: true)

        let expect = expectation(description: "Expected opacity to have changed")
        expect.expectedFulfillmentCount = 2

        var opacities = [CGFloat]()
        sut.$opacity.subscribe(in: &self.cancellables) { opacity in
            opacities.append(opacity)
            expect.fulfill()
        }

        // WHEN
        sut.isEnabled = false

        wait(for: [expect], timeout: 0.01)

        // THEN
        XCTAssertEqual(opacities, [1.0, self.theme.dims.dim3])
    }

    func test_intent_the_same_no_color_updates() {
        // GIVEN
        let sut = self.sut(intent: .basic)

        // WHEN
        sut.intent = .basic

        // THEN
        XCTAssertEqual(self.useCase.executeWithColorsAndIntentCallsCount, 1, "Expected use case to only have been called once")

        let arguments = self.useCase.executeWithColorsAndIntentReceivedArguments

        XCTAssertEqual(arguments?.intent, .basic, "Expected argument of use case to be basic")
    }

    func test_is_enabled_not_updated_no_line_color_updates() {
        // GIVEN
        let sut = self.sut(isEnabled: true)

        let expect = expectation(description: "Expected opacity to have changed")
        expect.isInverted = true

        sut.$opacity.dropFirst().subscribe(in: &self.cancellables) { opacity in
            expect.fulfill()
        }

        // WHEN
        sut.isEnabled = true

        wait(for: [expect], timeout: 0.01)
    }

    func test_theme_produces_different_line_color() {

        // GIVEN
        let colors = [UIColor.red, .blue]
        self.useCase.executeWithColorsAndIntentReturnValue = ColorTokenGeneratedMock.init(uiColor: colors[0])
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

        self.useCase.executeWithColorsAndIntentReturnValue = ColorTokenGeneratedMock.init(uiColor: colors[1])
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
