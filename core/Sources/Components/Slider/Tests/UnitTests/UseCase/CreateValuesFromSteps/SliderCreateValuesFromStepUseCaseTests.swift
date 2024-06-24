//
//  SliderCreateValuesFromStepUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SliderCreateValuesFromStepsUseCaseTests: XCTestCase {

    private let sut = SliderCreateValuesFromStepsUseCase()

    func test_execute_throws_invalid_range() {
        XCTAssertThrowsError(try self.sut.execute(from: 800, to: 200, steps: 4), "Execute should throw") { error in
            XCTAssertEqual(
                error as? SliderCreateValuesFromStepsUseCasableError,
                SliderCreateValuesFromStepsUseCasableError.invalidRange,
                "Error should be \(SliderCreateValuesFromStepsUseCasableError.invalidRange) but is \(error)"
            )
        }
    }

    func test_execute_throws_invalid_step_less_than_zero() {
        XCTAssertThrowsError(try self.sut.execute(from: 200, to: 800, steps: -1), "Execute should throw") { error in
            XCTAssertEqual(
                error as? SliderCreateValuesFromStepsUseCasableError,
                SliderCreateValuesFromStepsUseCasableError.invalidStep,
                "Error should be \(SliderCreateValuesFromStepsUseCasableError.invalidStep) but is \(error)"
            )
        }

    }

    func test_execute_throws_invalid_step_zero() {
        XCTAssertThrowsError(try self.sut.execute(from: 200, to: 800, steps: .zero), "Execute should throw") { error in
            XCTAssertEqual(
                error as? SliderCreateValuesFromStepsUseCasableError,
                SliderCreateValuesFromStepsUseCasableError.invalidStep,
                "Error should be \(SliderCreateValuesFromStepsUseCasableError.invalidStep) but is \(error)"
            )
        }

    }

    func test_execute_throws_invalid_step_greater_than_to_minus_from() {
        XCTAssertThrowsError(try self.sut.execute(from: 200, to: 800, steps: 800), "Execute should throw") { error in
            XCTAssertEqual(
                error as? SliderCreateValuesFromStepsUseCasableError,
                SliderCreateValuesFromStepsUseCasableError.invalidStep,
                "Error should be \(SliderCreateValuesFromStepsUseCasableError.invalidStep) but is \(error)"
            )
        }
    }

    func test_execute_adding_last_value() throws {
        let values = try XCTUnwrap(self.sut.execute(from: 0, to: 1, steps: 0.7),
                                   "Couldn't unwrap values")
        XCTAssertEqual(values, [0, 0.7, 1])
    }

    func test_execute() throws {
        let values = try XCTUnwrap(self.sut.execute(from: 50_000, to: 200_000, steps: 50_000),
                                   "Couldn't unwrap values")
        XCTAssertEqual(values, [
            50_000,
            100_000,
            150_000,
            200_000
        ])
    }
}
