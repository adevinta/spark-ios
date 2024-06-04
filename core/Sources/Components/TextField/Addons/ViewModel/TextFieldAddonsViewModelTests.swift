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
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
import SparkThemingTesting

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

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()

        self.expectedColors = .mocked(
            text: .blue(),
            placeholder: .green(),
            border: .yellow(),
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

    func test_set_backgroundColor() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newBackgroundColor = ColorTokenDefault.clear

        // WHEN
        self.viewModel.textFieldViewModel.backgroundColor = newBackgroundColor

        // THEN
        XCTAssertEqual(self.publishers.backgroundColor.sinkCount, 1, "backgroundColor should have been called once")
        XCTAssertTrue(self.viewModel.backgroundColor.equals(newBackgroundColor), "Wrong backgroundColor")
    }

    func test_setBorderLayout() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newValue = TextFieldBorderLayout(radius: -1, width: -2)
        self.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReturnValue = newValue

        // WHEN
        self.viewModel.textFieldViewModel.setBorderLayout()

        // THEN
        XCTAssertEqual(self.publishers.borderWidth.sinkCount, 1, "borderWidth should have been called once")
        XCTAssertEqual(self.viewModel.borderWidth, newValue.width, "Wrong borderWidth")
        XCTAssertEqual(self.publishers.borderRadius.sinkCount, 1, "borderRadius should have been called once")
        XCTAssertEqual(self.viewModel.borderRadius, newValue.radius, "Wrong borderRadius")
    }

    func test_setSpacings() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newValue = TextFieldSpacings(left: -1, content: -2, right: -3)
        self.getSpacingsUseCase.executeWithThemeAndBorderStyleReturnValue = newValue

        // WHEN
        self.viewModel.textFieldViewModel.setSpacings()

        // THEN
        XCTAssertEqual(self.publishers.leftSpacing.sinkCount, 1, "leftSpacing should have been called once")
        XCTAssertEqual(self.viewModel.leftSpacing, newValue.left, "Wrong leftSpacing")
        XCTAssertEqual(self.publishers.contentSpacing.sinkCount, 1, "contentSpacing should have been called once")
        XCTAssertEqual(self.viewModel.contentSpacing, newValue.content, "Wrong contentSpacing")
        XCTAssertEqual(self.publishers.rightSpacing.sinkCount, 1, "rightSpacing should have been called once")
        XCTAssertEqual(self.viewModel.rightSpacing, newValue.right, "Wrong rightSpacing")
    }

    func test_set_dim() {
        self.resetUseCases() // Removes execute from init
        self.publishers.reset() // Removes publishes from init

        // GIVEN
        let newDim = self.theme.dims.none + 1

        // WHEN
        self.viewModel.textFieldViewModel.dim = newDim

        // THEN
        XCTAssertEqual(self.publishers.dim.sinkCount, 1, "dim should have been called once")
        XCTAssertEqual(self.viewModel.dim, newDim, "Wrong dim")
    }

    // MARK: - Utils
    private func setupPublishers() {
        self.publishers = .init(
            backgroundColor: PublisherMock(publisher: self.viewModel.$backgroundColor),
            borderRadius: PublisherMock(publisher: self.viewModel.$borderRadius),
            borderWidth: PublisherMock(publisher: self.viewModel.$borderWidth),
            leftSpacing: PublisherMock(publisher: self.viewModel.$leftSpacing),
            contentSpacing: PublisherMock(publisher: self.viewModel.$contentSpacing),
            rightSpacing: PublisherMock(publisher: self.viewModel.$rightSpacing),
            dim: PublisherMock(publisher: self.viewModel.$dim)
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

    var backgroundColor: PublisherMock<Published<any ColorToken>.Publisher>

    var borderRadius: PublisherMock<Published<CGFloat>.Publisher>
    var borderWidth: PublisherMock<Published<CGFloat>.Publisher>

    var leftSpacing: PublisherMock<Published<CGFloat>.Publisher>
    var contentSpacing: PublisherMock<Published<CGFloat>.Publisher>
    var rightSpacing: PublisherMock<Published<CGFloat>.Publisher>

    var dim: PublisherMock<Published<CGFloat>.Publisher>

    init(
        backgroundColor: PublisherMock<Published<any ColorToken>.Publisher>,
        borderRadius: PublisherMock<Published<CGFloat>.Publisher>,
        borderWidth: PublisherMock<Published<CGFloat>.Publisher>,
        leftSpacing: PublisherMock<Published<CGFloat>.Publisher>,
        contentSpacing: PublisherMock<Published<CGFloat>.Publisher>,
        rightSpacing: PublisherMock<Published<CGFloat>.Publisher>,
        dim: PublisherMock<Published<CGFloat>.Publisher>
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
