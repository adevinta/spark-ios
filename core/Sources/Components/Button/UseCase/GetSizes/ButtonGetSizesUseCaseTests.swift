//
//  ButtonGetSizesUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetSizesUseCaseTests: XCTestCase {

    // MARK: - Tests With Only Icon

    func test_execute_when_switchSize_is_small_case_and_isOnlyIcon_is_true() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .small,
            isOnlyIcon: true
        )

        // THEN
        XCTAssertEqual(sizes.height, 32, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 16, "Wrong iconSize value")
    }

    func test_execute_when_switchSize_is_medium_case_and_isOnlyIcon_is_true() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .medium,
            isOnlyIcon: true
        )

        // THEN
        XCTAssertEqual(sizes.height, 44, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 16, "Wrong iconSize value")
    }

    func test_execute_when_switchSize_is_large_case_and_isOnlyIcon_is_true() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .large,
            isOnlyIcon: true
        )

        // THEN
        XCTAssertEqual(sizes.height, 56, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 24, "Wrong iconSize value")
    }

    // MARK: - Tests Without Only Icon

    func test_execute_when_switchSize_is_small_case_and_isOnlyIcon_is_false() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .small,
            isOnlyIcon: false
        )

        // THEN
        XCTAssertEqual(sizes.height, 32, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 16, "Wrong iconSize value")
    }

    func test_execute_when_switchSize_is_medium_case_and_isOnlyIcon_is_false() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .medium,
            isOnlyIcon: false
        )

        // THEN
        XCTAssertEqual(sizes.height, 44, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 16, "Wrong iconSize value")
    }

    func test_execute_when_switchSize_is_large_case_and_isOnlyIcon_is_false() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            for: .large,
            isOnlyIcon: false
        )

        // THEN
        XCTAssertEqual(sizes.height, 56, "Wrong height value")
        XCTAssertEqual(sizes.iconSize, 16, "Wrong iconSize value")
    }
}
