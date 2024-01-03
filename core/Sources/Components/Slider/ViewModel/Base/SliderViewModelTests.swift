//
//  SliderViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 02/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import Combine
@testable import SparkCore

final class SliderViewModelTests: SliderViewModelWithMocksTests {

    override func setUp() {
        super.setUp()
        self.viewModel = SliderViewModel(
            theme: self.theme,
            shape: self.shape,
            intent: self.intent,
            getColorsUseCase: self.getColorsUseCase,
            getCornerRadiiUseCase: self.getCornerRadiiUseCase,
            getStepValuesInBoundsUseCase: self.getStepValuesInBoundsUseCase,
            getClosestValueUseCase: self.getClosestValueUseCase
        )
        self.setupPublishers()
    }

    // MARK: - init
    func test_init() throws {
        // GIVEN / WHEN - Inits from setUp()
        // THEN - Simple variables
        XCTAssertIdentical(self.viewModel.theme as? ThemeGeneratedMock, self.theme, "Wrong theme")
        XCTAssertEqual(self.viewModel.intent, self.intent, "Wrong theme")
        XCTAssertEqual(self.viewModel.shape, self.shape, "Wrong shape")
        XCTAssertEqual(self.viewModel.dim, self.theme.dims.none, "Wrong dim")
        XCTAssertNil(self.viewModel.step, "step should be nil")
        XCTAssertNil(self.viewModel.stepValues, "stepValues should be nil")

        // THEN - Corner Radii
        XCTAssertEqual(self.getCornerRadiiUseCase.executeWithThemeAndShapeCallsCount, 1, "getCornerRadiiUseCase.executeWithThemeAndShape should be called once")
        let radiiReceivedArguments = try XCTUnwrap(self.getCornerRadiiUseCase.executeWithThemeAndShapeReceivedArguments, "Couldn't unwrap radiiReceivedArguments")
        XCTAssertEqual(radiiReceivedArguments.shape, self.shape, "Wrong radiiReceivedArguments.shape")
        XCTAssertIdentical(radiiReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong radiiReceivedArguments.theme")
        XCTAssertEqual(self.viewModel.trackRadius, self.expectedRadii.trackRadius, "Wrong trackRadius")
        XCTAssertEqual(self.viewModel.indicatorRadius, self.expectedRadii.indicatorRadius, "Wrong indicatorRadius")

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntent should be called once")
        let colorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentReceivedArguments, "Couldn't unwrap colorsReceivedArguments")
        XCTAssertEqual(colorsReceivedArguments.intent, self.intent, "Wrong colorsReceivedArguments.intent")
        XCTAssertIdentical(colorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong colorsReceivedArguments.theme")
        XCTAssertEqual(self.viewModel.trackColor.uiColor, self.expectedColors.track.uiColor, "Wrong trackColor")
        XCTAssertEqual(self.viewModel.indicatorColor.uiColor, self.expectedColors.indicator.uiColor, "Wrong indicatorColor")
        XCTAssertEqual(self.viewModel.handleColor.uiColor, self.expectedColors.handle.uiColor, "Wrong handleColor")
        XCTAssertEqual(self.viewModel.handleActiveIndicatorColor.uiColor, self.expectedColors.handleActiveIndicator.uiColor, "Wrong handleActiveIndicatorColor")

        // THEN - StepValuesInBounds
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")

        // THEN - ClosestValues
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
        XCTAssertEqual(self.publishers.handleColor.sinkCount, 1, "$handleColor should have been called once")
        XCTAssertEqual(self.publishers.handleActiveIndicatorColor.sinkCount, 1, "$handleActiveIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackColor.sinkCount, 1, "$trackColor should have been called once")
        XCTAssertEqual(self.publishers.indicatorColor.sinkCount, 1, "$indicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackRadius.sinkCount, 1, "$trackRadius should have been called once")
        XCTAssertEqual(self.publishers.indicatorRadius.sinkCount, 1, "$indicatorRadius should have been called once")
    }

    // MARK: - Theme
    func test_theme_didSet() throws {
        // GIVEN - Inits from setUp()
        let newTheme = ThemeGeneratedMock()
        newTheme.colors = ColorsGeneratedMock.mocked()
        newTheme.dims = DimsGeneratedMock.mocked()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.theme = newTheme

        // THEN - Var
        XCTAssertIdentical(self.viewModel.theme as? ThemeGeneratedMock, newTheme, "Wrong theme")

        // THEN - Corner Radii
        XCTAssertEqual(self.getCornerRadiiUseCase.executeWithThemeAndShapeCallsCount, 1, "getCornerRadiiUseCase.executeWithThemeAndShape should be called once")
        let radiiReceivedArguments = try XCTUnwrap(self.getCornerRadiiUseCase.executeWithThemeAndShapeReceivedArguments, "Couldn't unwrap radiiReceivedArguments")
        XCTAssertIdentical(radiiReceivedArguments.theme as? ThemeGeneratedMock, newTheme, "Wrong radiiReceivedArguments.theme")

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntent should be called once")
        let colorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentReceivedArguments, "Couldn't unwrap colorsReceivedArguments")
        XCTAssertIdentical(colorsReceivedArguments.theme as? ThemeGeneratedMock, newTheme, "Wrong colorsReceivedArguments.theme")

        // THEN - StepValuesInBounds
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")

        // THEN - ClosestValues
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
        XCTAssertEqual(self.publishers.handleColor.sinkCount, 1, "$handleColor should have been called once")
        XCTAssertEqual(self.publishers.handleActiveIndicatorColor.sinkCount, 1, "$handleActiveIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackColor.sinkCount, 1, "$trackColor should have been called once")
        XCTAssertEqual(self.publishers.indicatorColor.sinkCount, 1, "$indicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackRadius.sinkCount, 1, "$trackRadius should have been called once")
        XCTAssertEqual(self.publishers.indicatorRadius.sinkCount, 1, "$indicatorRadius should have been called once")
    }

    // MARK: - Is Enabled
    func test_isEnabled_didSet_not_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isEnabled = false

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should be called once")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_isEnabled_didSet_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.isEnabled = true

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: - Intent
    func test_intent_didSet_not_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.intent = .neutral

        // THEN - UseCases
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntent should have been called once")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertEqual(self.publishers.handleColor.sinkCount, 1, "$handleColor should have been called once")
        XCTAssertEqual(self.publishers.handleActiveIndicatorColor.sinkCount, 1, "$handleActiveIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackColor.sinkCount, 1, "$trackColor should have been called once")
        XCTAssertEqual(self.publishers.indicatorColor.sinkCount, 1, "$indicatorColor should have been called once")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_intent_didSet_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.intent = self.intent

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: - Shape
    func test_shape_didSet_not_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.shape = .square

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertEqual(self.getCornerRadiiUseCase.executeWithThemeAndShapeCallsCount, 1, "getCornerRadiiUseCase.executeWithThemeAndShape should have been called once")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertEqual(self.publishers.trackRadius.sinkCount, 1, "$trackRadius should have been called once")
        XCTAssertEqual(self.publishers.indicatorRadius.sinkCount, 1, "$indicatorRadius should have been called once")
    }

    func test_shape_didSet_equal() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.shape = self.shape

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: - Step
    func test_step_same_value() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.step = nil

        // THEN
        XCTAssertNil(self.viewModel.stepValues, "stepValues should be nil")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_step_new_value() throws {
        // GIVEN - Inits from setUp()
        let expectedStepValues: [Float] = [0, 1, 2]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = expectedStepValues
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.step = 0.3

        // THEN
        XCTAssertEqual(self.viewModel.stepValues, expectedStepValues, "Wrong stepValues")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")
        XCTAssertEqual(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCallsCount, 1, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn have been called")
        let receivedArguments = try XCTUnwrap(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.step, 0.3, "Wrong received step")
        XCTAssertEqual(receivedArguments.bounds, 0...1, "Wrong received bounds")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_step_nil_value() throws {
        // GIVEN - Inits from setUp()
        let expectedStepValues: [Float] = [0, 1, 2]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = expectedStepValues
        self.viewModel.step = 0.3
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.step = nil

        // THEN
        XCTAssertNil(self.viewModel.stepValues, "stepValues should be nil")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: - Bounds
    func test_bounds_same_value() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.viewModel.bounds = 0...1

        // THEN
        XCTAssertNil(self.viewModel.stepValues, "stepValues should be nil")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_bounds_new_value() throws {
        // GIVEN - Inits from setUp()
        let expectedStepValues: [Float] = [0, 1, 2]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = expectedStepValues
        self.viewModel.step = 0.4 // Changing bounds will not change stepValues unless step isn't nil
        self.resetUseCases() // Removes previous executes
        self.publishers.reset() // Removes previous publishes

        // WHEN
        self.viewModel.bounds = 0...4

        // THEN
        XCTAssertEqual(self.viewModel.stepValues, expectedStepValues, "Wrong stepValues")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")
        XCTAssertEqual(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCallsCount, 1, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn have been called")
        let receivedArguments = try XCTUnwrap(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.step, 0.4, "Wrong received step")
        XCTAssertEqual(receivedArguments.bounds, 0...4, "Wrong received bounds")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: - Get Closest Value
    func test_getClosestValue_default_variables() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: 0.4)

        // THEN
        XCTAssertEqual(returnedValue, 0.4, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_getClosestValue_custom_variables() throws {
        // GIVEN - Inits from setUp()
        let stepValues: [Float] = [0, 3, 6, 9]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = stepValues
        self.getClosestValueUseCase.executeWithValueAndValuesReturnValue = 6
        self.viewModel.step = 3
        self.viewModel.bounds = 0...10
        self.resetUseCases() // Removes previous executes
        self.publishers.reset() // Removes previous publishes

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: 5)

        // THEN
        XCTAssertEqual(returnedValue, 6.0, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithValueAndValuesCallsCount, 1, "getClosestValueUseCase.executeWithValueAndValues should have been called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithValueAndValuesReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.value, 5, "Wrong received value")
        XCTAssertEqual(receivedArguments.values, stepValues, "Wrong received value")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_getClosestValue_value_over_bounds() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: 2)

        // THEN
        XCTAssertEqual(returnedValue, 1, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_getClosestValue_value_under_bounds() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: -1)

        // THEN
        XCTAssertEqual(returnedValue, 0, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    // MARK: Reset Bounds If Needed
    func test_resetBoundsIfNeeded_is_not_needed() {
        // GIVEN - Inits from setUp()
        let expectedStepValues: [Float] = [0, 0.3, 1]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = expectedStepValues
        self.viewModel.step = 0.4 // Changing bounds will not change stepValues unless step isn't nil
        self.resetUseCases() // Removes previous executes
        self.publishers.reset() // Removes previous publishes

        // WHEN
        self.viewModel.resetBoundsIfNeeded()

        // THEN
        XCTAssertEqual(self.viewModel.bounds, 0...1, "Wrong bounds")
        XCTAssertEqual(self.viewModel.stepValues, expectedStepValues, "Wrong stepValues")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCalled, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }

    func test_resetBoundsIfNeeded_is_needed() throws {
        // GIVEN - Inits from setUp()
        let expectedStepValues: [Float] = [0, 0.3, 0.6, 0.9]
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = expectedStepValues
        self.viewModel.step = 0.3 // Changing bounds will not change stepValues unless step isn't nil
        self.resetUseCases() // Removes previous executes
        self.publishers.reset() // Removes previous publishes

        // WHEN
        self.viewModel.resetBoundsIfNeeded()

        // THEN
        XCTAssertEqual(self.viewModel.bounds, 0...0.9, "Wrong bounds")
        XCTAssertEqual(self.viewModel.stepValues, expectedStepValues, "Wrong stepValues")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertFalse(self.getClosestValueUseCase.executeWithValueAndValuesCalled, "getClosestValueUseCase.executeWithValueAndValues shouldn't have been called")
        XCTAssertEqual(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepCallsCount, 1, "getStepValuesInBoundsUseCase.executeWithBoundsAndStep should have been called once")
        let receivedArguments = try XCTUnwrap(self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.step, 0.3, "Wrong received step")
        XCTAssertEqual(receivedArguments.bounds, 0...0.9, "Wrong received bounds")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim shouldn't have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor shouldn't have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor shouldn't have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius shouldn't have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius shouldn't have been called")
    }
}

class SliderPublishers {
    var cancellables = Set<AnyCancellable>()
    var dim: PublisherMock<Published<CGFloat>.Publisher>
    var trackColor: PublisherMock<Published<ColorToken>.Publisher>
    var handleColor: PublisherMock<Published<ColorToken>.Publisher>
    var indicatorColor: PublisherMock<Published<ColorToken>.Publisher>
    var handleActiveIndicatorColor: PublisherMock<Published<ColorToken>.Publisher>
    var trackRadius: PublisherMock<Published<CGFloat>.Publisher>
    var indicatorRadius: PublisherMock<Published<CGFloat>.Publisher>

    init(dim: PublisherMock<Published<CGFloat>.Publisher>,
         trackColor: PublisherMock<Published<ColorToken>.Publisher>,
         handleColor: PublisherMock<Published<ColorToken>.Publisher>,
         indicatorColor: PublisherMock<Published<ColorToken>.Publisher>,
         handleActiveIndicatorColor: PublisherMock<Published<ColorToken>.Publisher>,
         trackRadius: PublisherMock<Published<CGFloat>.Publisher>,
         indicatorRadius: PublisherMock<Published<CGFloat>.Publisher>) {
        self.dim = dim
        self.trackColor = trackColor
        self.handleColor = handleColor
        self.indicatorColor = indicatorColor
        self.handleActiveIndicatorColor = handleActiveIndicatorColor
        self.trackRadius = trackRadius
        self.indicatorRadius = indicatorRadius
    }

    func load() {
        self.cancellables = Set<AnyCancellable>()
        [self.dim, self.trackRadius, self.indicatorRadius].forEach {
            $0.loadTesting(on: &self.cancellables)
        }
        [self.trackColor, self.handleColor, self.indicatorColor, self.handleActiveIndicatorColor].forEach {
            $0.loadTesting(on: &self.cancellables)
        }
    }

    func reset() {
        [self.dim, self.trackRadius, self.indicatorRadius].forEach {
            $0.reset()
        }
        [self.trackColor, self.handleColor, self.indicatorColor, self.handleActiveIndicatorColor].forEach {
            $0.reset()
        }
    }
}
