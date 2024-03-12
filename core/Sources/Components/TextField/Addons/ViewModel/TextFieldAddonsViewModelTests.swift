//
//  TextFieldAddonsViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 21/03/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import Combine
@testable import SparkCore

final class TextFieldAddonsViewModelTests: XCTestCase {
    private var theme: ThemeGeneratedMock!
    private var publishers: TextFieldAddonsPublishers!
    private var getColorsUseCase: TextFieldGetColorsUseCasableGeneratedMock!
    private var getBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasableGeneratedMock!
    private var getSpacingsUseCase: TextFieldGetSpacingsUseCasableGeneratedMock!
    private var viewModel: TextFieldAddonsViewModel!

    private let intent = TextFieldIntent.success
    private let borderStyle = TextFieldBorderStyle.roundedRect

    private var expectedColors: TextFieldColors!
    private var expectedBorderLayout: TextFieldBorderLayout!
    private var expectedSpacings: TextFieldSpacings!

    private let successImage: ImageEither = .left(UIImage(systemName: "square.and.arrow.up.fill")!)
    private let alertImage: ImageEither = .right(Image(systemName: "rectangle.portrait.and.arrow.right.fill"))
    private let errorImage: ImageEither = .left(UIImage(systemName: "eraser.fill")!)

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()

        self.expectedColors = .mocked(
            text: .blue(),
            placeholder: .green(),
            border: .yellow(),
            statusIcon: .red(),
            background: .purple()
        )
        self.expectedBorderLayout = .mocked(radius: 1, width: 2)
        self.expectedSpacings = .mocked(left: 1, content: 2, right: 3)

        self.getColorsUseCase = .mocked(returnedColors: self.expectedColors)
        self.getBorderLayoutUseCase = .mocked(returnedBorderLayout: self.expectedBorderLayout)
        self.getSpacingsUseCase = .mocked(returnedSpacings: self.expectedSpacings)
        self.viewModel = .init(
            theme: self.theme,
            intent: self.intent,
            successImage: self.successImage,
            alertImage: self.alertImage,
            errorImage: self.errorImage,
            getColorsUseCase: self.getColorsUseCase,
            getBorderLayoutUseCase: self.getBorderLayoutUseCase,
            getSpacingsUseCase: self.getSpacingsUseCase
        )

        self.setupPublishers()
    }

    func test_init() throws {
        // GIVEN / WHEN - Inits from setUp()

        // THEN - Colors
        XCTAssertEqual(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledCallsCount, 1, "getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabled should have been called once")
        let getColorsReceivedArguments = try XCTUnwrap(self.getColorsUseCase.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReceivedArguments, "Couldn't unwrap getColorsReceivedArguments")
        XCTAssertIdentical(getColorsReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getColorsReceivedArguments.theme")
        XCTAssertEqual(getColorsReceivedArguments.intent, self.intent, "Wrong getColorsReceivedArguments.intent")
        XCTAssertFalse(getColorsReceivedArguments.isFocused, "Wrong getColorsReceivedArguments.isFocused")
        XCTAssertTrue(getColorsReceivedArguments.isEnabled, "Wrong getColorsReceivedArguments.isEnabled")
        XCTAssertTrue(getColorsReceivedArguments.isUserInteractionEnabled, "Wrong getColorsReceivedArguments.isUserInteractionEnabled")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(self.expectedColors.background), "Wrong backgroundColor")

        // THEN - Border Layout
        XCTAssertEqual(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 2, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called twice (one for textfield, one for addons)")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertIdentical(getBorderLayoutReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getBorderLayoutReceivedArguments.theme")
        XCTAssertEqual(getBorderLayoutReceivedArguments.borderStyle, .roundedRect, "Wrong getBorderLayoutReceivedArguments.borderStyle")
        XCTAssertFalse(getBorderLayoutReceivedArguments.isFocused, "Wrong getBorderLayoutReceivedArguments.isFocused")
        XCTAssertEqual(self.viewModel.borderWidth, self.expectedBorderLayout.width, "Wrong borderWidth")
        XCTAssertEqual(self.viewModel.borderRadius, self.expectedBorderLayout.radius, "Wrong borderRadius")

        // THEN - Spacings
        XCTAssertEqual(self.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 2, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called twice (one for textfield, one for addons)")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertIdentical(getSpacingsUseCaseReceivedArguments.theme as? ThemeGeneratedMock, self.theme, "Wrong getSpacingsUseCaseReceivedArguments.theme")
        XCTAssertEqual(getSpacingsUseCaseReceivedArguments.borderStyle, .roundedRect, "Wrong getSpacingsUseCaseReceivedArguments.borderStyle")
        XCTAssertEqual(self.viewModel.leftSpacing, self.expectedSpacings.left, "Wrong leftSpacing")
        XCTAssertEqual(self.viewModel.contentSpacing, self.expectedSpacings.content, "Wrong contentSpacing")
        XCTAssertEqual(self.viewModel.rightSpacing, self.expectedSpacings.right, "Wrong rightSpacing")

        XCTAssertEqual(self.viewModel.dim, self.theme.dims.none, "Wrong dim")

        // THEN - Publishers
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "$backgroundColor should have been called once")

        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "$borderWidth should have been called once")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "$borderRadius should have been called once")

        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "$leftSpacing should have been called once")
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "$contentSpacing should have been called once")
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "$rightSpacing should have been called once")

        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "$dim should have been called once")
    }

    func test_backgroundColor_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBackgroundColor = self.expectedColors.background

        // WHEN
        self.viewModel.backgroundColor = newBackgroundColor

        // THEN
        XCTAssertFalse(self.publishers.backgroundColor.sinkCalled)
    }

    func test_backgroundColor_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBackgroundColor = ColorTokenDefault.clear

        // WHEN
        self.viewModel.backgroundColor = newBackgroundColor

        // THEN
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "backgroundColor should have been called once")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newBackgroundColor), "Wrong backgroundColor")
    }

    func test_borderWidth_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBorderWidth = self.expectedBorderLayout.width

        // WHEN
        self.viewModel.borderWidth = newBorderWidth

        // THEN
        XCTAssertFalse(self.publishers.borderWidth.sinkCalled)
    }

    func test_borderWidth_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBorderWidth = self.expectedBorderLayout.width - 1

        // WHEN
        self.viewModel.borderWidth = newBorderWidth

        // THEN
        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "borderWidth should have been called once")
        XCTAssertEqual(self.viewModel.borderWidth, newBorderWidth, "Wrong borderWidth")
    }

    func test_borderRadius_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBorderRadius = self.expectedBorderLayout.radius

        // WHEN
        self.viewModel.borderRadius = newBorderRadius

        // THEN
        XCTAssertFalse(self.publishers.borderRadius.sinkCalled)
    }

    func test_borderRadius_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBorderRadius = self.expectedBorderLayout.radius - 1

        // WHEN
        self.viewModel.borderRadius = newBorderRadius

        // THEN
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "borderRadius should have been called once")
        XCTAssertEqual(self.viewModel.borderRadius, newBorderRadius, "Wrong borderRadius")
    }

    func test_spacingLeft_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newLeftSpacing = self.expectedSpacings.left

        // WHEN
        self.viewModel.leftSpacing = newLeftSpacing

        // THEN
        XCTAssertFalse(self.publishers.leftSpacing.sinkCalled)
    }

    func test_leftSpacing_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newLeftSpacing = self.expectedSpacings.left - 1

        // WHEN
        self.viewModel.leftSpacing = newLeftSpacing

        // THEN
        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "leftSpacing should have been called once")
        XCTAssertEqual(self.viewModel.leftSpacing, newLeftSpacing, "Wrong leftSpacing")
    }

    func test_spacingContent_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newContentSpacing = self.expectedSpacings.content

        // WHEN
        self.viewModel.contentSpacing = newContentSpacing

        // THEN
        XCTAssertFalse(self.publishers.contentSpacing.sinkCalled)
    }

    func test_contentSpacing_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newContentSpacing = self.expectedSpacings.content - 1

        // WHEN
        self.viewModel.contentSpacing = newContentSpacing

        // THEN
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "contentSpacing should have been called once")
        XCTAssertEqual(self.viewModel.contentSpacing, newContentSpacing, "Wrong contentSpacing")
    }

    func test_spacingRight_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newRightSpacing = self.expectedSpacings.right

        // WHEN
        self.viewModel.rightSpacing = newRightSpacing

        // THEN
        XCTAssertFalse(self.publishers.rightSpacing.sinkCalled)
    }

    func test_rightSpacing_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newRightSpacing = self.expectedSpacings.right - 1

        // WHEN
        self.viewModel.rightSpacing = newRightSpacing

        // THEN
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "rightSpacing should have been called once")
        XCTAssertEqual(self.viewModel.rightSpacing, newRightSpacing, "Wrong rightSpacing")
    }

    func test_dim_set_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newDim = self.theme.dims.none

        // WHEN
        self.viewModel.dim = newDim

        // THEN
        XCTAssertFalse(self.publishers.dim.sinkCalled)
    }

    func test_dim_set_not_equal() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newDim = self.theme.dims.none + 1

        // WHEN
        self.viewModel.dim = newDim

        // THEN
        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "dim should have been called once")
        XCTAssertEqual(self.viewModel.dim, newDim, "Wrong dim")
    }

    // MARK: - Utils
    private func setupPublishers() {
        self.publishers = .init(
            backgroundColor: PublisherMock(publisher: self.viewModel.backgroundColorSubject),
            borderRadius: PublisherMock(publisher: self.viewModel.borderRadiusSubject),
            borderWidth: PublisherMock(publisher: self.viewModel.borderWidthSubject),
            leftSpacing: PublisherMock(publisher: self.viewModel.leftSpacingSubject),
            contentSpacing: PublisherMock(publisher: self.viewModel.contentSpacingSubject),
            rightSpacing: PublisherMock(publisher: self.viewModel.rightSpacingSubject),
            dim: PublisherMock(publisher: self.viewModel.dimSubject)
        )
        self.publishers.load()
    }

    private func resetUseCases() {
        self.getColorsUseCase.reset()
        self.getBorderLayoutUseCase.reset()
        self.getSpacingsUseCase.reset()
    }
}

final class TextFieldAddonsPublishers {
    var cancellables = Set<AnyCancellable>()

    var backgroundColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>

    var borderRadius: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var borderWidth: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    var leftSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var contentSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    var rightSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    var dim: PublisherMock<CurrentValueSubject<CGFloat, Never>>

    init(
        backgroundColor: PublisherMock<CurrentValueSubject<any ColorToken, Never>>,
        borderRadius: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        borderWidth: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        leftSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        contentSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        rightSpacing: PublisherMock<CurrentValueSubject<CGFloat, Never>>,
        dim: PublisherMock<CurrentValueSubject<CGFloat, Never>>
    ) {
        self.backgroundColor = backgroundColor
        self.borderRadius = borderRadius
        self.borderWidth = borderWidth
        self.leftSpacing = leftSpacing
        self.contentSpacing = contentSpacing
        self.rightSpacing = rightSpacing
        self.dim = dim
    }

    func load() {
        self.cancellables = Set<AnyCancellable>()

        [self.backgroundColor].forEach {
            $0.loadTesting(on: &self.cancellables)
        }

        [self.borderWidth, self.borderRadius, self.leftSpacing, self.contentSpacing, self.rightSpacing, self.dim].forEach {
            $0.loadTesting(on: &self.cancellables)
        }
    }

    func reset() {
        [self.backgroundColor].forEach {
            $0.reset()
        }

        [self.borderWidth, self.borderRadius, self.leftSpacing, self.contentSpacing, self.rightSpacing, self.dim].forEach {
            $0.reset()
        }
    }
}
