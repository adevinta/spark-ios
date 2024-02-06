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

    // MARK: Properties
    var theme: ThemeGeneratedMock!
    var spacingsUseCase: ProgressTrackerGetSpacingsUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.spacingsUseCase = ProgressTrackerGetSpacingsUseCaseableGeneratedMock()
        self.spacingsUseCase.executeWithSpacingAndOrientationReturnValue = .stub()
    }

    // MARK: - Tests
    func test_vertical_setup() {
        // GIVEN
        let _ = self.sut(orientation: .vertical)

        // THEN
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .vertical, "Orientation expected to have been vertical")
    }

    func test_horizontal_setup() {
        // GIVEN
        let _ = self.sut(orientation: .horizontal)

        // THEN
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1, "Spacings use case expected to have been called")

        let spacingsParameters = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments

        XCTAssertEqual(spacingsParameters?.orientation, .horizontal, "Orientation expected to be have been horizontal")
    }

    func test_theme_changed() {
        // GIVEN
        let sut = self.sut(orientation: .horizontal)
        let expectation = expectation(description: "Wait for spacing & font change")
        expectation.expectedFulfillmentCount = 2

        Publishers.Zip(sut.$spacings, sut.$font).sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        sut.theme = ThemeGeneratedMock.mocked()

        // THEN
        wait(for: [expectation], timeout: 1)
    }

    func test_enabled_status_changed() {
        // GIVEN
        let sut = self.sut(orientation: . vertical)
        let expectation = expectation(description: "Wait for color change")
        expectation.expectedFulfillmentCount = 2

        sut.$labelColor.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        sut.isEnabled = false

        // THEN
        wait(for: [expectation], timeout: 1)
    }

    func test_orientation_is_changed_spacings_updated() {
        // GIVEN
        let sut = self.sut(orientation: . vertical)
        let expectation = expectation(description: "Wait for spacings to be change")
        expectation.expectedFulfillmentCount = 2

        sut.$spacings.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        sut.orientation = .horizontal

        // THEN
        wait(for: [expectation], timeout: 1)
        let arguments = self.spacingsUseCase.executeWithSpacingAndOrientationReceivedArguments
        XCTAssertIdentical(arguments?.spacing as? LayoutSpacingGeneratedMock, self.theme.layout.spacing as? LayoutSpacingGeneratedMock)
        XCTAssertEqual(arguments?.orientation, .horizontal)
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 2)
    }

    func test_orientation_is_not_changed_spacings_is_not_updated() {
        // GIVEN
        let sut = self.sut(orientation: . vertical)

        // WHEN
        sut.orientation = .vertical

        // THEN
        XCTAssertEqual(self.spacingsUseCase.executeWithSpacingAndOrientationCallsCount, 1)

    }

    func test_change_show_default_page_number() {
        // GIVEN
        let sut = sut(orientation: .vertical, showDefaultPageNumber: false)

        XCTAssertFalse(sut.content.showDefaultPageNumber, "Expected show default page number of content to be false")
        XCTAssertFalse(sut.showDefaultPageNumber, "Expected show default page number to be false")

        // WHEN
        sut.showDefaultPageNumber = true

        // THEN
        XCTAssertTrue(sut.content.showDefaultPageNumber, "Expected show default page number of content to be true")
        XCTAssertTrue(sut.showDefaultPageNumber, "Expected show default page number to be true")
    }

    func test_change_number_of_pages() {
        // GIVEN
        let sut = sut(orientation: .vertical, numberOfPages: 2)

        XCTAssertEqual(sut.content.numberOfPages, 2, "Expected number of pages of content to be 2")
        XCTAssertEqual(sut.numberOfPages, 2, "Expected number of pages to be 2")

        // WHEN
        sut.numberOfPages = 6

        // THEN
        XCTAssertEqual(sut.content.numberOfPages, 6, "Expected number of pages of content to be 6")
        XCTAssertEqual(sut.numberOfPages, 6, "Expected number of pages to be 6")
    }

    func test_change_current_page_index() {
        // GIVEN
        let sut = sut(orientation: .vertical, numberOfPages: 4)
        let allGivenExpected: [(given: Int, expected: Int)] = [(-1, 0), (0, 0), (3, 3), (4, 3) ]

        for givenExpected in allGivenExpected {
            // WHEN
            sut.currentPageIndex = givenExpected.given

            // THEN
            XCTAssertEqual(sut.currentPageIndex, givenExpected.expected, "Expected current page index when set to \(givenExpected.given) to be \(givenExpected.expected)")

        }
    }

    // MARK: - Private helper functions
    private func sut(
        orientation: ProgressTrackerOrientation,
        numberOfPages: Int = 4,
        showDefaultPageNumber: Bool = true
    ) -> ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent> {
        let content = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: numberOfPages,
            currentPageIndex: 0,
            showDefaultPageNumber: showDefaultPageNumber)
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
