//
//  ProgressBarGetAnimatedDataUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 29/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ProgressBarGetAnimatedDataUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let trackWidth: CGFloat = 100

    // MARK: - Tests

    func test_execute_when_type_is_easeIn() {
        self.testExecute(
            givenType: .easeIn,
            expectedAnimatedData: .init(
                leadingSpaceWidth: ((self.trackWidth - self.trackWidth * 0.5) / 2),
                indicatorWidth: self.trackWidth * 0.5
            )
        )
    }

    func test_execute_when_type_is_easeOut() {
        self.testExecute(
            givenType: .easeOut,
            expectedAnimatedData: .init(
                leadingSpaceWidth: self.trackWidth,
                indicatorWidth: 0
            )
        )
    }

    func test_execute_when_type_is_reset() {
        self.testExecute(
            givenType: .reset,
            expectedAnimatedData: .init(
                leadingSpaceWidth: 0,
                indicatorWidth: 0
            )
        )
    }

    func test_execute_when_type_is_none() {
        self.testExecute(
            givenType: .none,
            expectedAnimatedData: .init(
                leadingSpaceWidth: 0,
                indicatorWidth: 0
            )
        )
    }
}

// MARK: - Execute Testing

private extension ProgressBarGetAnimatedDataUseCaseTests {

    func testExecute(
        givenType: ProgressIndeterminateBarAnimationType?,
        expectedAnimatedData: ProgressBarAnimatedData
    ) {
        // GIVEN
        let useCase = ProgressBarGetAnimatedDataUseCase()

        // WHEN
        let animatedData = useCase.execute(
            type: givenType,
            trackWidth: self.trackWidth
        )

        // THEN
        XCTAssertEqual(
            animatedData,
            expectedAnimatedData
        )
    }
}
