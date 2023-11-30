//
//  SliderGetClosestValueUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SliderGetClosestValueUseCaseTests: XCTestCase {

    func test_execute_createValuesFromStep_receivedValues() throws {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            return [1, 2, 3]
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        _ = sut.execute(from: 2, to: 20, withSteps: 1, fromValue: 15)

        // THEN
        XCTAssertEqual(createValuesFromStepUseCaseMock.executeWithFromAndToAndStepsCallsCount,
                       1,
                       "executeWithFromAndToAndStepsCallsCount should be called once")
        let receivedArguments = try XCTUnwrap(createValuesFromStepUseCaseMock.executeWithFromAndToAndStepsReceivedArguments)
        XCTAssertEqual(receivedArguments.from, 2, "Wrong receivedArguments.from")
        XCTAssertEqual(receivedArguments.to, 20, "Wrong receivedArguments.to")
        XCTAssertEqual(receivedArguments.steps, 1, "Wrong receivedArguments.steps")
    }

    func test_execute_createValuesFromStep_throws_invalidRange() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            throw SliderCreateValuesFromStepsUseCasableError.invalidRange
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 100, withSteps: 10, fromValue: 40)

        // THEN
        XCTAssertEqual(value, 40)
    }

    func test_execute_createValuesFromStep_throws_invalid() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            throw SliderCreateValuesFromStepsUseCasableError.invalidStep
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 100, withSteps: 10, fromValue: 30)

        // THEN
        XCTAssertEqual(value, 30)
    }

    func test_execute_createValuesFromStep_empty_values() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            return []
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 100, withSteps: 10, fromValue: 60)

        // THEN
        XCTAssertEqual(value, 60)
    }

    func test_execute_inbetween() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            return [
                0,
                10,
                20,
                30,
                40,
                50
            ]
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 50, withSteps: 0.1, fromValue: 25)

        // THEN
        XCTAssertEqual(value, 30)
    }

    func test_execute_lower() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            return [
                0.0,
                0.5
            ]
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 0.5, withSteps: 0.1, fromValue: 0.249)

        // THEN
        XCTAssertEqual(value, 0.0)
    }

    func test_execute_upper() {
        // GIVEN
        let createValuesFromStepUseCaseMock = SliderCreateValuesFromStepsUseCasableGeneratedMock()
        createValuesFromStepUseCaseMock._executeWithFromAndToAndSteps = { _, _ , _ throws -> [Float] in
            return [
                0.0,
                0.1,
                0.4,
                0.5
            ]
        }
        let sut = SliderGetClosestValueUseCase(createValuesFromStepsUseCase: createValuesFromStepUseCaseMock)

        // WHEN
        let value = sut.execute(from: 0, to: 0.5, withSteps: 0.1, fromValue: 0.251)

        // THEN
        XCTAssertEqual(value, 0.4)
    }
}
