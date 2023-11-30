//
//  SingleSliderViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 11/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SingleSliderViewModelTests: SliderViewModelTests<SingleSliderViewModel> {

    var singlePublishers: SingleSliderPublishers {
        return self.publishers as! SingleSliderPublishers
    }

    override func setupPublishers() {
        self.publishers = SingleSliderPublishers(
            dim: PublisherMock(publisher: self.viewModel.$dim),
            trackColor: PublisherMock(publisher: self.viewModel.$trackColor),
            handleColor: PublisherMock(publisher: self.viewModel.$handleColor),
            indicatorColor: PublisherMock(publisher: self.viewModel.$indicatorColor),
            handleActiveIndicatorColor: PublisherMock(publisher: self.viewModel.$handleActiveIndicatorColor),
            trackRadius: PublisherMock(publisher: self.viewModel.$trackRadius),
            indicatorRadius: PublisherMock(publisher: self.viewModel.$indicatorRadius),
            value: PublisherMock(publisher: self.viewModel.$value)
        )
        self.publishers.load()
    }

    func test_setAbsoluteValue_outOfBounds() throws {
        // GIVEN
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init
        self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReturnValue = 1
        self.viewModel.minimumValue = 0
        self.viewModel.maximumValue = 4
        self.viewModel.steps = 1

        // WHEN
        self.viewModel.setAbsoluteValue(2)

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCallsCount, 1, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn have been called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.value, 2, "Wrong receivedArguments.value")
        XCTAssertEqual(receivedArguments.from, 0, "Wrong receivedArguments.from")
        XCTAssertEqual(receivedArguments.to, 4, "Wrong receivedArguments.to")
        XCTAssertEqual(receivedArguments.steps, 1, "Wrong receivedArguments.steps")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
        XCTAssertEqual(self.singlePublishers.value.sinkValue, 1, "Wrong value.sinkValue")
    }

    func test_setAbsoluteValue_outOfBounds_under() throws {
        // GIVEN
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init
        self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReturnValue = 3
        self.viewModel.minimumValue = 0
        self.viewModel.maximumValue = 4
        self.viewModel.steps = 1

        // WHEN
        self.viewModel.setAbsoluteValue(-1)

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCallsCount, 1, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn have been called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.value, 0, "Wrong receivedArguments.value")
        XCTAssertEqual(receivedArguments.from, 0, "Wrong receivedArguments.from")
        XCTAssertEqual(receivedArguments.to, 4, "Wrong receivedArguments.to")
        XCTAssertEqual(receivedArguments.steps, 1, "Wrong receivedArguments.steps")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
        XCTAssertEqual(self.singlePublishers.value.sinkValue, 3, "Wrong value.sinkValue")
    }

    func test_setAbsoluteValue_outOfBounds_over() throws {
        // GIVEN
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init
        self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReturnValue = 2
        self.viewModel.minimumValue = 0
        self.viewModel.maximumValue = 4
        self.viewModel.steps = 1

        // WHEN
        self.viewModel.setAbsoluteValue(5)

        // THEN - UseCases
        XCTAssertFalse(self.getColorsUseCase.executeWithThemeAndIntentCalled, "getColorsUseCase.executeWithThemeAndIntent shouldn't have been called")
        XCTAssertFalse(self.getCornerRadiiUseCase.executeWithThemeAndShapeCalled, "getCornerRadiiUseCase.executeWithThemeAndShape shouldn't have been called")
        XCTAssertEqual(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueCallsCount, 1, "getClosestValueUseCase.executeWithFromAndToAndStepsAndValue shouldn have been called once")
        let receivedArguments = try XCTUnwrap(self.getClosestValueUseCase.executeWithFromAndToAndStepsAndValueReceivedArguments, "Couldn't unwrap receivedArguments")
        XCTAssertEqual(receivedArguments.value, 4, "Wrong receivedArguments.value")
        XCTAssertEqual(receivedArguments.from, 0, "Wrong receivedArguments.from")
        XCTAssertEqual(receivedArguments.to, 4, "Wrong receivedArguments.to")
        XCTAssertEqual(receivedArguments.steps, 1, "Wrong receivedArguments.steps")

        // THEN - Publishers
        XCTAssertFalse(self.publishers.dim.sinkCalled, "$dim should not have been called")
        XCTAssertFalse(self.publishers.handleColor.sinkCalled, "$handleColor should not have been called")
        XCTAssertFalse(self.publishers.handleActiveIndicatorColor.sinkCalled, "$handleActiveIndicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackColor.sinkCalled, "$trackColor should not have been called")
        XCTAssertFalse(self.publishers.indicatorColor.sinkCalled, "$indicatorColor should not have been called")
        XCTAssertFalse(self.publishers.trackRadius.sinkCalled, "$trackRadius should not have been called")
        XCTAssertFalse(self.publishers.indicatorRadius.sinkCalled, "$indicatorRadius should not have been called")
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
        XCTAssertEqual(self.singlePublishers.value.sinkValue, 2, "Wrong value.sinkValue")
    }

    func test_init_value() throws {
        // GIVEN / WHEN - Inits from setUp()

        // THEN
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }
}

final class SingleSliderPublishers: SliderPublishers {
    var value: PublisherMock<Published<Float>.Publisher>

    init(dim: PublisherMock<Published<CGFloat>.Publisher>,
         trackColor: PublisherMock<Published<ColorToken>.Publisher>,
         handleColor: PublisherMock<Published<ColorToken>.Publisher>,
         indicatorColor: PublisherMock<Published<ColorToken>.Publisher>,
         handleActiveIndicatorColor: PublisherMock<Published<ColorToken>.Publisher>,
         trackRadius: PublisherMock<Published<CGFloat>.Publisher>,
         indicatorRadius: PublisherMock<Published<CGFloat>.Publisher>,
         value: PublisherMock<Published<Float>.Publisher>) {
        self.value = value
        super.init(dim: dim,
                   trackColor: trackColor,
                   handleColor: handleColor,
                   indicatorColor: indicatorColor,
                   handleActiveIndicatorColor: handleActiveIndicatorColor,
                   trackRadius: trackRadius,
                   indicatorRadius: indicatorRadius)
    }

    override func load() {
        super.load()
        self.value.loadTesting(on: &self.cancellables)
    }

    override func reset() {
        super.reset()
        self.value.reset()
    }
}
