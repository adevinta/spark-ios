//
//  SliderViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import Combine
@testable import SparkCore

class SliderViewModelTests<T: SliderViewModel>: XCTestCase {
    private let intent = SliderIntent.info
    private let shape = SliderShape.rounded
    private let expectedRadii = SliderRadii.mocked()

    private var theme: ThemeGeneratedMock!
    var viewModel: T!
    private var expectedColors: SliderColors!
    var getColorsUseCase: SliderGetColorsUseCasableGeneratedMock!
    var getCornerRadiiUseCase: SliderGetCornerRadiiUseCasableGeneratedMock!
    var getClosestValueUseCase: SliderGetClosestValueUseCasableGeneratedMock!
    var publishers: SliderPublishers!

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        self.expectedColors = SliderColors.mocked(colors: self.theme.colors)
        self.getColorsUseCase = SliderGetColorsUseCasableGeneratedMock.mocked(returnedColors: self.expectedColors)
        self.getCornerRadiiUseCase = SliderGetCornerRadiiUseCasableGeneratedMock.mocked(expectedRadii: self.expectedRadii)
        self.getClosestValueUseCase = SliderGetClosestValueUseCasableGeneratedMock()
        self.viewModel = T(
            theme: self.theme,
            shape: self.shape,
            intent: self.intent,
            getColorsUseCase: self.getColorsUseCase,
            getCornerRadiiUseCase: self.getCornerRadiiUseCase,
            getClosestValueUseCase: self.getClosestValueUseCase
        )
        self.setupPublishers()
    }

    func setupPublishers() {
        self.publishers = SliderPublishers(
            dim: PublisherMock(publisher: self.viewModel.$dim),
            trackColor: PublisherMock(publisher: self.viewModel.$trackColor),
            handleColor: PublisherMock(publisher: self.viewModel.$handleColor),
            indicatorColor: PublisherMock(publisher: self.viewModel.$indicatorColor),
            handleActiveIndicatorColor: PublisherMock(publisher: self.viewModel.$handleActiveIndicatorColor),
            trackRadius: PublisherMock(publisher: self.viewModel.$trackRadius),
            indicatorRadius: PublisherMock(publisher: self.viewModel.$indicatorRadius)
        )
        self.publishers.load()
    }

    // MARK: - init
    func test_init() throws {
        // GIVEN / WHEN - Inits from setUp()
        // THEN - Simple variables
        XCTAssertIdentical(self.viewModel.theme as? ThemeGeneratedMock, self.theme, "Wrong theme")
        XCTAssertEqual(self.viewModel.intent, self.intent, "Wrong theme")
        XCTAssertEqual(self.viewModel.shape, self.shape, "Wrong shape")
        XCTAssertEqual(self.viewModel.dim, self.theme.dims.none, "Wrong dim")

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

        // THEN - ClosestValues
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

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

        // THEN - ClosestValues
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should be called once")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertEqual(self.publishers.handleColor.sinkCount, 1, "$handleColor should have been called once")
        XCTAssertEqual(self.publishers.handleActiveIndicatorColor.sinkCount, 1, "$handleActiveIndicatorColor should have been called once")
        XCTAssertEqual(self.publishers.trackColor.sinkCount, 1, "$trackColor should have been called once")
        XCTAssertEqual(self.publishers.indicatorColor.sinkCount, 1, "$indicatorColor should have been called once")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
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
        XCTAssertFalse(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCalled, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn't have been called")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
    }

    // MARK: - Get Closest Value
    func test_getClosestValue_default_variables() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init
        self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReturnValue = 0.31

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: 0.4)

        // THEN
        XCTAssertEqual(returnedValue, 0.31, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape should not have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCallsCount, 1, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue should be called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.from, 0, "Wrong received from")
        XCTAssertEqual(receivedArguments.to, 1, "Wrong received to")
        XCTAssertEqual(receivedArguments.steps, 0.0, "Wrong received steps")
        XCTAssertEqual(receivedArguments.value, 0.4, "Wrong received value")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
    }

    func test_getClosestValue_updated_variables() throws {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init
        self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReturnValue = 7.6
        self.viewModel.steps = 0.5
        self.viewModel.minimumValue = 1
        self.viewModel.maximumValue = 10

        // WHEN
        let returnedValue = self.viewModel.getClosestValue(fromValue: 4.23)

        // THEN
        XCTAssertEqual(returnedValue, 7.6, "Wrong returnedValue")

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape should not have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCallsCount, 1, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue should be called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.from, 1, "Wrong received from")
        XCTAssertEqual(receivedArguments.to, 10, "Wrong received to")
        XCTAssertEqual(receivedArguments.steps, 0.5, "Wrong received steps")
        XCTAssertEqual(receivedArguments.value, 4.23, "Wrong received value")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
    }

    func resetUseCases() {
        self.getColorsUseCase.reset()
        self.getCornerRadiiUseCase.reset()
        self.getClosestValueUseCase.reset()
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
