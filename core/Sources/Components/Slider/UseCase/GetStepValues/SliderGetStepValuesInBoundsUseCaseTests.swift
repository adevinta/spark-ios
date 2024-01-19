//
//  SliderGetStepValuesInBoundsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SliderGetStepValuesInBoundsUseCaseTests: XCTestCase {

    func test_execute_with_step_multiplier_of_upperBound() {
        // GIVEN
        let useCase = SliderGetStepValuesInBoundsUseCase()
        let bounds: ClosedRange<Double> = 0...1
        let step: Double = 0.25
        let expectedStepValues: [Double] = [0, 0.25, 0.50, 0.75, 1.0]

        // WHEN
        let stepValues = useCase.execute(bounds: bounds, step: step)

        // THEN
        XCTAssertEqual(stepValues, expectedStepValues)
    }

    func test_execute_with_step_not_a_multiplier_of_upperBound() {
        // GIVEN
        let useCase = SliderGetStepValuesInBoundsUseCase()
        let bounds: ClosedRange<Float> = 0...10
        let step: Float = 3
        let expectedStepValues: [Float] = [0, 3, 6, 9]

        // WHEN
        let stepValues = useCase.execute(bounds: bounds, step: step)

        // THEN
        XCTAssertEqual(stepValues, expectedStepValues)
    }
}
