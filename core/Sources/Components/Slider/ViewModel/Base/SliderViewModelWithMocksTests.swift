//
//  SliderViewModelWithMocksTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 03/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import Combine
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonTesting
import SparkThemingTesting

class SliderViewModelWithMocksTests: XCTestCase {
    let intent = SliderIntent.info
    let shape = SliderShape.rounded
    let expectedRadii = SliderRadii.mocked()

    var theme: ThemeGeneratedMock!
    var viewModel: SliderViewModel<Float>!
    var expectedColors: SliderColors!
    var getColorsUseCase: SliderGetColorsUseCasableGeneratedMock!
    var getCornerRadiiUseCase: SliderGetCornerRadiiUseCasableGeneratedMock!
    var getStepValuesInBoundsUseCase: SliderGetStepValuesInBoundsUseCasableMock<Float>!
    var getClosestValueUseCase: SliderGetClosestValueUseCasableMock<Float>!

    var publishers: SliderPublishers!

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

    func resetUseCases() {
        self.getColorsUseCase.reset()
        self.getCornerRadiiUseCase.reset()
        self.getClosestValueUseCase.reset()
        self.getStepValuesInBoundsUseCase.reset()
    }

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        self.expectedColors = SliderColors.mocked(colors: self.theme.colors)
        self.getColorsUseCase = SliderGetColorsUseCasableGeneratedMock.mocked(returnedColors: self.expectedColors)
        self.getCornerRadiiUseCase = SliderGetCornerRadiiUseCasableGeneratedMock.mocked(expectedRadii: self.expectedRadii)
        self.getStepValuesInBoundsUseCase = SliderGetStepValuesInBoundsUseCasableMock<Float>()
        self.getClosestValueUseCase = SliderGetClosestValueUseCasableMock<Float>()
    }
}
