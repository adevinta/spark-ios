//
//  ButtonGetHeightUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetHeightUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_when_switchSize_is_small_case() {
        // GIVEN
        let useCase = ButtonGetHeightUseCase()

        // WHEN
        let height = useCase.execute(forSize: .small)

        // THEN
        XCTAssertEqual(height, 32)
    }

    func test_execute_when_switchSize_is_medium_case() {
        // GIVEN
        let useCase = ButtonGetHeightUseCase()

        // WHEN
        let height = useCase.execute(forSize: .medium)

        // THEN
        XCTAssertEqual(height, 44)
    }

    func test_execute_when_switchSize_is_large_case() {
        // GIVEN
        let useCase = ButtonGetHeightUseCase()

        // WHEN
        let height = useCase.execute(forSize: .large)

        // THEN
        XCTAssertEqual(height, 56)
    }
}
