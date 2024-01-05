//
//  SliderGetClosestValueUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SliderGetClosestValueUseCaseTests: XCTestCase {

    func test_execute_under_minimum_value() {
        // GIVEN
        let useCase = SliderGetClosestValueUseCase()
        let values: [CGFloat] = [10, 20, 30]
        let value: CGFloat = 0
        let expectedClosestValue: CGFloat = 10

        // WHEN
        let closestValue = useCase.execute(value: value, in: values)

        // THEN
        XCTAssertEqual(closestValue, expectedClosestValue)
    }

    func test_execute_over_maximum_value() {
        // GIVEN
        let useCase = SliderGetClosestValueUseCase()
        let values: [Double] = [0.1, 0.2, 0.3]
        let value: Double = 0.4
        let expectedClosestValue: Double = 0.3

        // WHEN
        let closestValue = useCase.execute(value: value, in: values)

        // THEN
        XCTAssertEqual(closestValue, expectedClosestValue)
    }

    func test_execute_lower_rounding() {
        // GIVEN
        let useCase = SliderGetClosestValueUseCase()
        let values: [Float] = [0.0, 0.50, 1.0, 1.50]
        let value: Float = 0.74
        let expectedClosestValue: Float = 0.50

        // WHEN
        let closestValue = useCase.execute(value: value, in: values)

        // THEN
        XCTAssertEqual(closestValue, expectedClosestValue)
    }

    func test_execute_upper_rounding() {
        // GIVEN
        let useCase = SliderGetClosestValueUseCase()
        let values: [CGFloat] = [0.0, 0.50, 1.0, 1.50]
        let value: CGFloat = 0.76
        let expectedClosestValue: CGFloat = 1.0

        // WHEN
        let closestValue = useCase.execute(value: value, in: values)

        // THEN
        XCTAssertEqual(closestValue, expectedClosestValue)

    }

    func test_execute_inbetween() {
        // GIVEN
        let useCase = SliderGetClosestValueUseCase()
        let values: [CGFloat] = [0.0, 0.50, 1.0, 1.50]
        let value: CGFloat = 0.75
        let expectedClosestValue: CGFloat = 1.0

        // WHEN
        let closestValue = useCase.execute(value: value, in: values)

        // THEN
        XCTAssertEqual(closestValue, expectedClosestValue)
    }
}
