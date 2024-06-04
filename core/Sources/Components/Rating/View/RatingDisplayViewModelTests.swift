//
//  RatingDisplayViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//
import Combine
import XCTest
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
import SparkThemingTesting

final class RatingDisplayViewModelTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!
    var colorsUseCase: RatingGetColorsUseCaseableGeneratedMock!
    var sizeUseCase: RatingSizeAttributesUseCaseableGeneratedMock!
    var sut: RatingDisplayViewModel!
    var subscriptions: Set<AnyCancellable>!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.colorsUseCase = RatingGetColorsUseCaseableGeneratedMock()
        self.sizeUseCase = RatingSizeAttributesUseCaseableGeneratedMock()
        self.theme = ThemeGeneratedMock.mocked()
        self.subscriptions = .init()

        self.colorsUseCase.executeWithThemeAndIntentAndStateReturnValue = RatingColors(
            fillColor: self.theme.colors.main.onMain,
            strokeColor: self.theme.colors.base.background,
            opacity: 1.0)

        self.sizeUseCase.executeWithSpacingAndSizeReturnValue = RatingSizeAttributes(borderWidth: 2.0, height: 20, spacing: 8)


        self.sut = RatingDisplayViewModel(
            theme: self.theme,
            intent: .main,
            size: .small,
            count: .five,
            rating: 1.0,
            colorsUseCase: self.colorsUseCase,
            sizeUseCase: self.sizeUseCase
        )
    }

    override func tearDown() {
        super.tearDown()
        self.subscriptions.removeAll()
    }

    // MARK: - Tests
    func test_setup() {
        // Then
        XCTAssertEqual(self.sut.colors.opacity, 1.0, "Expected opacity to 0.0")
        XCTAssertEqual(self.sut.colors.fillColor.uiColor, self.theme.colors.main.onMain.uiColor, "Expected fill color to be onMain")
        XCTAssertEqual(self.sut.colors.strokeColor.uiColor, self.theme.colors.base.background.uiColor, "Expected background color to be set")
        XCTAssertEqual(self.sut.ratingValue, 1.0)
    }

    func test_single_star() {
        // Given
        self.sut.rating = 2
        self.sut.count = .one

        XCTAssertEqual(self.sut.ratingValue, 0.4)
    }

    func test_theme_updated() {

        // Given
        let colorsPublisherMock: PublisherMock<Published< RatingColors>.Publisher> = .init(publisher: self.sut.$colors)
        let ratingSizePublisherMock: PublisherMock<Published<RatingSizeAttributes>.Publisher> = .init(publisher: self.sut.$ratingSize)

        colorsPublisherMock.loadTesting(on: &subscriptions)
        ratingSizePublisherMock.loadTesting(on: &subscriptions)

        // When
        self.sut.theme = self.theme

        // Then
        XCTAssertPublisherSinkCountEqual(
            on: colorsPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: ratingSizePublisherMock,
            2
        )
    }

    func test_rating_size_did_update() {
        // Given
        let ratingSizePublisherMock: PublisherMock<Published<RatingSizeAttributes>.Publisher> = .init(publisher: self.sut.$ratingSize)

        ratingSizePublisherMock.loadTesting(on: &subscriptions)

        // When
        self.sut.size = .input

        // Then
        XCTAssertPublisherSinkCountEqual(
            on: ratingSizePublisherMock,
            2
        )
    }

    func test_rating_count_did_update() {
        // Given
        let ratingValuePublisherMock: PublisherMock<Published<CGFloat>.Publisher> = .init(publisher: self.sut.$ratingValue)

        ratingValuePublisherMock.loadTesting(on: &subscriptions)

        // When
        self.sut.count = .one

        // Then
        XCTAssertPublisherSinkCountEqual(
            on: ratingValuePublisherMock,
            2
        )

        XCTAssertEqual(self.sut.ratingValue, self.sut.rating / 5.0)
    }

    func test_rating_did_update() {
        // Given
        let ratingValuePublisherMock: PublisherMock<Published<CGFloat>.Publisher> = .init(publisher: self.sut.$ratingValue)

        ratingValuePublisherMock.loadTesting(on: &subscriptions)

        // When
        self.sut.count = .one
        self.sut.rating = 4

        // Then
        XCTAssertPublisherSinkCountEqual(
            on: ratingValuePublisherMock,
            3
        )

        XCTAssertEqual(self.sut.ratingValue, self.sut.rating / 5.0)
    }
}
