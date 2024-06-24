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

    // MARK: - Test Type is .iconButton

    func test_execute_when_switchSize_is_small_case_and_type_is_iconButton() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .small,
            type: .iconButton
        )

        // THEN
        XCTAssertEqual(sizes.height, 32, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 16, "Wrong imageSize value")
    }

    func test_execute_when_switchSize_is_medium_case_and_type_is_iconButton() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .medium,
            type: .iconButton
        )

        // THEN
        XCTAssertEqual(sizes.height, 44, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 16, "Wrong imageSize value")
    }

    func test_execute_when_switchSize_is_large_case_and_type_is_iconButton() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .large,
            type: .iconButton
        )

        // THEN
        XCTAssertEqual(sizes.height, 56, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 24, "Wrong imageSize value")
    }

    // MARK: - Test Type is .button

    func test_execute_when_switchSize_is_small_case_and_type_is_button() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .small,
            type: .button
        )

        // THEN
        XCTAssertEqual(sizes.height, 32, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 16, "Wrong imageSize value")
    }

    func test_execute_when_switchSize_is_medium_case_and_type_is_button() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .medium,
            type: .button
        )

        // THEN
        XCTAssertEqual(sizes.height, 44, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 16, "Wrong imageSize value")
    }

    func test_execute_when_switchSize_is_large_case_and_type_is_button() {
        // GIVEN
        let useCase = ButtonGetSizesUseCase()

        // WHEN
        let sizes = useCase.execute(
            size: .large,
            type: .button
        )

        // THEN
        XCTAssertEqual(sizes.height, 56, "Wrong height value")
        XCTAssertEqual(sizes.imageSize, 16, "Wrong imageSize value")
    }
}
