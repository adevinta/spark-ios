//
//  ProgressBarValueViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkCore

final class ProgressBarValueViewModelTests: XCTestCase {

    // MARK: - Tests

    func test_isValidIndicatorValue_when_value_parameter_is_valid() throws {
        // GIVEN
        let viewModel = ProgressBarValueViewModelMock()

        let values = [
            0,
            0.3,
            0.5,
            0.8,
            1.0
        ]

        // WHEN
        for value in values {
            let isValid = viewModel.isValidIndicatorValue(value)

            // THEN
            XCTAssertTrue(
                isValid,
                "Wrong isValid when value is \(value)"
            )
        }
    }

    func test_isValidIndicatorValue_when_value_parameter_is_invalid() throws {
        // GIVEN
        let viewModel = ProgressBarValueViewModelMock()

        let values = [
            -0.1 as CGFloat,
             -2,
             1.1,
             2
        ]

        // WHEN
        for value in values {
            let value = viewModel.isValidIndicatorValue(value)

            // THEN
            XCTAssertFalse(
                value,
                "Wrong isValid when value is \(value)"
            )
        }
    }
}

// MARK: - Mock

private struct ProgressBarValueViewModelMock: ProgressBarValueViewModel {
}
