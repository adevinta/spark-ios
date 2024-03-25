//
//  TextFieldViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import Combine
import UIKit
import SwiftUI
@testable import SparkCore

final class TextFieldViewModelForAddonsTests: XCTestCase {

    private let superTests: TextFieldViewModelTests = .init()
    private var viewModel: TextFieldViewModelForAddons!

    override func setUp() {
        super.setUp()
        self.superTests.setUp()

        self.viewModel = .init(
            theme: self.superTests.theme,
            intent: self.superTests.intent,
            successImage: self.superTests.successImage,
            alertImage: self.superTests.alertImage,
            errorImage: self.superTests.errorImage,
            getColorsUseCase: self.superTests.getColorsUseCase,
            getBorderLayoutUseCase: self.superTests.getBorderLayoutUseCase,
            getSpacingsUseCase: self.superTests.getSpacingsUseCase
        )
    }

    func test_init_borderStyle() {
        XCTAssertEqual(self.viewModel.borderStyle, .none, "Wrong borderStyle")
        XCTAssertNil(self.viewModel.delegate, "Delegate should be nil")
    }

    func test_backgroundColor() {
        self.superTests.publishers.reset()
        self.superTests.resetUseCases()

        let delegate = TextFieldViewModelForAddonsDelegateGeneratedMock()
        self.viewModel.delegate = delegate

        XCTAssertTrue(self.viewModel.backgroundColor.equals(ColorTokenDefault.clear), "Wrong viewModel.backgroundColor before set")

        let newColor = ColorTokenGeneratedMock(uiColor: .brown)
        self.viewModel.backgroundColor = newColor

        XCTAssertTrue(self.viewModel.backgroundColor.equals(ColorTokenDefault.clear), "Wrong viewModel.backgroundColor after set")
        XCTAssertTrue(delegate.backgroundColor.equals(newColor), "Wrong delegate.backgroundColor")

        XCTAssertFalse(self.superTests.publishers.backgroundColor.sinkCalled, "backgroundColor should not have sinked")
    }

    func test_dim() {
        self.superTests.publishers.reset()
        self.superTests.resetUseCases()

        let delegate = TextFieldViewModelForAddonsDelegateGeneratedMock()
        self.viewModel.delegate = delegate

        XCTAssertEqual(self.viewModel.dim, 1.0, "Wrong viewModel.dim before set")

        let newDim = 0.2
        self.viewModel.dim = newDim

        XCTAssertEqual(self.viewModel.dim, 1.0, "Wrong viewModel.dim after set")
        XCTAssertEqual(delegate.dim, newDim, "Wrong delegate.dim")

        XCTAssertFalse(self.superTests.publishers.dim.sinkCalled, "dim should not have sinked")
    }

    func test_setBorderLayout() throws {
        self.superTests.publishers.reset()
        self.superTests.resetUseCases()

        let newExpectedBorderLayout: TextFieldBorderLayout = .mocked(radius: 40, width: 40)
        self.superTests.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReturnValue = newExpectedBorderLayout
        let delegate = TextFieldViewModelForAddonsDelegateGeneratedMock()
        self.viewModel.delegate = delegate

        // WHEN
        self.viewModel.setBorderLayout()

        // THEN
        XCTAssertEqual(delegate.borderWidth, newExpectedBorderLayout.width, "Wrong delegate.boderWidth")
        XCTAssertEqual(delegate.borderRadius, newExpectedBorderLayout.radius, "Wrong delegate.boderRadius")
        // Border with & Radius shouldn't change, the delegate takes charge
        XCTAssertEqual(self.viewModel.borderWidth, self.superTests.expectedBorderLayout.width, "Wrong viewModel.borderRadius")
        XCTAssertEqual(self.viewModel.borderRadius, self.superTests.expectedBorderLayout.radius, "Wrong viewModel.borderWidth")

        XCTAssertEqual(self.superTests.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedCallsCount, 1, "getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocused should have been called once")
        let getBorderLayoutReceivedArguments = try XCTUnwrap(self.superTests.getBorderLayoutUseCase.executeWithThemeAndBorderStyleAndIsFocusedReceivedArguments, "Couldn't unwrap getBorderLayoutReceivedArguments")
        XCTAssertIdentical(getBorderLayoutReceivedArguments.theme as? ThemeGeneratedMock, self.superTests.theme, "Wrong getBorderLayoutReceivedArguments.theme")
        XCTAssertEqual(getBorderLayoutReceivedArguments.borderStyle, .roundedRect, "Wrong getBorderLayoutReceivedArguments.borderStyle")
        XCTAssertFalse(getBorderLayoutReceivedArguments.isFocused, "Wrong getBorderLayoutReceivedArguments.isFocused")

        XCTAssertFalse(self.superTests.publishers.borderWidth.sinkCalled, "$borderWidth should not have been called")
        XCTAssertFalse(self.superTests.publishers.borderRadius.sinkCalled, "$borderRadius should not have been called")
    }

    func test_setSpacings() throws {
        self.superTests.publishers.reset()
        self.superTests.resetUseCases()

        let delegate = TextFieldViewModelForAddonsDelegateGeneratedMock()
        self.viewModel.delegate = delegate

        let newExpectedSpacings = TextFieldSpacings.mocked(left: 2, content: 4, right: 3)
        self.superTests.getSpacingsUseCase.executeWithThemeAndBorderStyleReturnValue = newExpectedSpacings

        // WHEN
        self.viewModel.setSpacings()

        // THEN
        XCTAssertEqual(delegate.leftSpacing, newExpectedSpacings.left)
        XCTAssertEqual(delegate.contentSpacing, newExpectedSpacings.content)
        XCTAssertEqual(delegate.rightSpacing, newExpectedSpacings.right)

        // Spacings shouldn't change, the delegate takes charge
        XCTAssertEqual(self.viewModel.leftSpacing, self.superTests.expectedSpacings.left)
        XCTAssertEqual(self.viewModel.contentSpacing, self.superTests.expectedSpacings.content)
        XCTAssertEqual(self.viewModel.rightSpacing, self.superTests.expectedSpacings.right)

        XCTAssertEqual(self.superTests.getSpacingsUseCase.executeWithThemeAndBorderStyleCallsCount, 1, "getSpacingsUseCase.executeWithThemeAndBorderStyle should have been called once")
        let getSpacingsUseCaseReceivedArguments = try XCTUnwrap(self.superTests.getSpacingsUseCase.executeWithThemeAndBorderStyleReceivedArguments, "Couldn't unwrap getSpacingsUseCaseReceivedArguments")
        XCTAssertIdentical(getSpacingsUseCaseReceivedArguments.theme as? ThemeGeneratedMock, self.superTests.theme, "Wrong getSpacingsUseCaseReceivedArguments.theme")
        XCTAssertEqual(getSpacingsUseCaseReceivedArguments.borderStyle, .roundedRect, "Wrong getSpacingsUseCaseReceivedArguments.borderStyle")

        XCTAssertFalse(self.superTests.publishers.leftSpacing.sinkCalled, "$leftSpacing should not have been called")
        XCTAssertFalse(self.superTests.publishers.contentSpacing.sinkCalled, "$contentSpacing should not have been called")
        XCTAssertFalse(self.superTests.publishers.rightSpacing.sinkCalled, "$rightSpacing should not have been called")
    }
}
