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
    var spacingsUseCase: ProgressTrackerGetSpacingsUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.spacingsUseCase = ProgressTrackerGetSpacingsUseCaseableGeneratedMock()
        self.spacingsUseCase.executeWithSpacingAndOrientationReturnValue = .stub()
    }

    func test_vertical_setup() {
        // Given
        let _ = self.sut(orientation: .vertical)

        // Then
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .vertical, "Orientation expected to have been vertical")
    }

    func test_horizontal_setup() {
        // Given
        let _ = self.sut(orientation: .horizontal)

        // Then
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Spacings use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .horizontal, "Orientation expected to be have been horizontal")
    }

    func test_theme_changed() {
        // Given
        let sut = self.sut(orientation: .horizontal)
        let expectation = expectation(description: "Wait for spacing & font change")
        expectation.expectedFulfillmentCount = 2

        Publishers.Zip(sut.$spacings, sut.$font).sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_enabled_status_changed() {
        // Given
        let sut = self.sut(orientation: . vertical)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        sut.$labelColor.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.isEnabled = false

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_orientation_is_changed() {
        // Given
        let sut = self.sut(orientation: . vertical)
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

    private func sut(orientation: ProgressTrackerOrientation) -> ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent> {
        let content = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 4, currentPage: 0)
        return ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>(
            theme: self.theme,
            orientation: orientation,
            content: content,
            spacingUseCase: self.spacingsUseCase
        )
    }
}

private extension ProgressTrackerSpacing {
    static func stub() -> ProgressTrackerSpacing {
        return ProgressTrackerSpacing(trackIndicatorSpacing: 1.0, minLabelSpacing: 2.0)
    }
}
