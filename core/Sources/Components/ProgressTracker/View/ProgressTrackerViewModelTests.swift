//
//  ProgressTrackerViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class ProgressTrackerViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var colorsUseCase: ProgressTrackerGetTrackColorUseCaseableGeneratedMock!
    var spacingsUseCase: ProgressTrackerGetSpacingsUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.colorsUseCase = ProgressTrackerGetTrackColorUseCaseableGeneratedMock()
        self.spacingsUseCase = ProgressTrackerGetSpacingsUseCaseableGeneratedMock()
        self.spacingsUseCase.executeWithSpacingAndOrientationReturnValue = .stub()
        self.colorsUseCase.executeWithThemeAndIntentAndIsEnabledReturnValue = ColorTokenGeneratedMock.random()
    }

    func test_vertical_setup() {
        // Given
        let _ = self.sut(intent: .alert, orientation: .vertical)

        // Then
        XCTAssertEqual(self.colorsUseCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 1, "Colors use case expected to have been called")

        let colorsParameters = self.colorsUseCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(colorsParameters?.intent, .alert, "Intent expected to be alert")
        XCTAssertTrue(colorsParameters?.isEnabled ?? false, "Is enabled expected to be true")

        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Spacings use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .vertical, "Orientation expected to have been vertical")
    }

    func test_horizontal_setup() {
        // Given
        let _ = self.sut(intent: .success, orientation: .horizontal)

        // Then
        XCTAssertEqual(self.colorsUseCase.executeWithThemeAndIntentAndIsEnabledCallsCount, 1, "Colors use case expected to have been called")

        let colorsParameters = self.colorsUseCase.executeWithThemeAndIntentAndIsEnabledReceivedArguments

        XCTAssertEqual(colorsParameters?.intent, .success, "Intent expected to be success")
        XCTAssertTrue(colorsParameters?.isEnabled ?? false, "Is enabled expected to be true")

        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Spacings use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .horizontal, "Orientation expected to be have been horizontal")

    }

    func test_change_intent() {
        // Given
        let sut = self.sut(intent: .success, orientation: .horizontal)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        sut.$trackColor.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.intent = .alert

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_theme_changed() {
        // Given
        let sut = self.sut(intent: .success, orientation: .horizontal)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        Publishers.Zip(sut.$trackColor, sut.$spacings).sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_enabled_status_changed() {
        // Given
        let sut = self.sut(intent: .info, orientation: . vertical)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        sut.$trackColor.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.isEnabled = false

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_orientation_is_changed() {
        // Given
        let sut = self.sut(intent: .info, orientation: . vertical)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        sut.$spacings.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.orientation = .horizontal

        // Then
        wait(for: [expectation], timeout: 1)
    }

    private func sut(intent: ProgressTrackerIntent, orientation: ProgressTrackerOrientation) -> ProgressTrackerViewModel {
        return .init(
            theme: self.theme,
            intent: intent,
            orientation: orientation,
            colorUseCase: self.colorsUseCase,
            spacingUseCase: self.spacingsUseCase
        )
    }

}

private extension ProgressTrackerSpacing {
    static func stub() -> ProgressTrackerSpacing {
        return ProgressTrackerSpacing(trackIndicatorSpacing: 1.0, minLabelSpacing: 2.0)
    }
}
