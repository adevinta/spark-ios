//
//  SingleSliderViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 03/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import Combine
@testable import SparkCore

final class SingleSliderViewModelTests: SliderViewModelWithMocksTests {
    var singleViewModel: SingleSliderViewModel<Float>!
    override var viewModel: SliderViewModel<Float>! {
        get { return self.singleViewModel }
        set { self.singleViewModel = newValue as? SingleSliderViewModel<Float> }
    }

    var singlePublishers: SingleSliderPublishers!
    override var publishers: SliderPublishers! {
        get { return self.singlePublishers }
        set { self.singlePublishers = newValue as? SingleSliderPublishers }
    }

    override func setUp() {
        super.setUp()
        self.singleViewModel = SingleSliderViewModel(
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

    override func setupPublishers() {
        self.singlePublishers = SingleSliderPublishers(
            dim: PublisherMock(publisher: self.viewModel.$dim),
            trackColor: PublisherMock(publisher: self.viewModel.$trackColor),
            handleColor: PublisherMock(publisher: self.viewModel.$handleColor),
            indicatorColor: PublisherMock(publisher: self.viewModel.$indicatorColor),
            handleActiveIndicatorColor: PublisherMock(publisher: self.viewModel.$handleActiveIndicatorColor),
            trackRadius: PublisherMock(publisher: self.viewModel.$trackRadius),
            indicatorRadius: PublisherMock(publisher: self.viewModel.$indicatorRadius),
            value: PublisherMock(publisher: self.singleViewModel.$value)
        )
        self.publishers.load()
    }

    // MARK: - init
    func test_init() throws {
        // GIVEN / WHEN - Inits from setUp()
        // THEN - Simple variables
        XCTAssertEqual(self.singleViewModel.value, 0.0, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    // MARK: - Set Value
    func test_setValue() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.setValue(0.5)

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.5, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_setValue_under_bounds() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.setValue(-1)

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_setValue_over_bounds() {
        // GIVEN - Inits from setUp()
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.setValue(2)

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 1, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_setValue_closest_value() {
        // GIVEN - Inits from setUp()
        self.getClosestValueUseCase.executeWithValueAndValuesReturnValue = 0.4
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = [0, 0.4, 1]
        self.viewModel.step = 0.3
        self.resetUseCases() // Removes previous executes
        self.publishers.reset() // Removes previous publishes

        // WHEN
        self.singleViewModel.setValue(0.5)

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.4, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    // MARK: - Increment value
    func test_incrementValue_withoutStep() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.setValue(0.5)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.incrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.6, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_incrementValue_withoutStep_customBounds() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.bounds = 200...800
        self.singleViewModel.setValue(400)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.incrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 460, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_incrementValue_withoutStep_overBound() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.setValue(0.95)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.incrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 1.0, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_incrementValue_withStep() {
        // GIVEN - Inits from setUp()
        self.getClosestValueUseCase.executeWithValueAndValuesReturnValue = 0.8
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = [0, 0.3, 0.8, 1.0]
        self.singleViewModel.setValue(0.5)
        self.singleViewModel.step = 0.3
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.incrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.8, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    // MARK: - Decrement value
    func test_decrementValue_withoutStep() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.setValue(0.5)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.decrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.4, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_decrementValue_withoutStep_customBounds() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.bounds = 200...800
        self.singleViewModel.setValue(400)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.decrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 340, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_decrementValue_withoutStep_overBound() {
        // GIVEN - Inits from setUp()
        self.singleViewModel.setValue(0.05)
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.decrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.0, "Wrong value")

        // THEN - Publishers
        XCTAssertEqual(self.singlePublishers.value.sinkCount, 1, "$value should have been called once")
    }

    func test_decrementValue_withStep() {
        // GIVEN - Inits from setUp()
        self.getClosestValueUseCase.executeWithValueAndValuesReturnValue = 0.2
        self.getStepValuesInBoundsUseCase.executeWithBoundsAndStepReturnValue = [0, 0.2, 0.8, 1.0]
        self.singleViewModel.setValue(0.5)
        self.singleViewModel.step = 0.3
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // WHEN
        self.singleViewModel.decrementValue()

        // THEN
        XCTAssertEqual(self.singleViewModel.value, 0.2, "Wrong value")

        // THEN - Publishers
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
        super.init(dim: dim, trackColor: trackColor, handleColor: handleColor, indicatorColor: indicatorColor, handleActiveIndicatorColor: handleActiveIndicatorColor, trackRadius: trackRadius, indicatorRadius: indicatorRadius)
    }

    override func load() {
        super.load()
        self.value.loadTesting(on: &super.cancellables)
    }

    override func reset() {
        super.reset()
        self.value.reset()
    }
}
