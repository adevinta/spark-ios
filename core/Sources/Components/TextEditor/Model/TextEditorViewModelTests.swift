//
//  TextEditorViewModelTest.swift
//  SparkCoreUnitTests
//
//  Created by alican.aycil on 18.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import XCTest
@testable import SparkCore

final class TextEditorViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var cancellable = Set<AnyCancellable>()
    var checkedImage = IconographyTests.shared.checkmark

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_init() throws {

        // Given
        let viewModel = TextEditorViewModel(
            theme: theme,
            intent: .neutral
        )

        // Then
        XCTAssertNotNil(viewModel.theme, "No theme set")
        XCTAssertNotNil(viewModel.intent, "No intent set")
        XCTAssertEqual(viewModel.horizontalSpacing, self.theme.layout.spacing.large)
        XCTAssertEqual(viewModel.font.uiFont, self.theme.typography.body1.uiFont)
        XCTAssertEqual(viewModel.textColor.uiColor, self.theme.colors.base.onSurface.uiColor)
        XCTAssertEqual(viewModel.placeholderColor.uiColor, self.theme.colors.base.onSurface.opacity(theme.dims.dim1).uiColor)
        XCTAssertEqual(viewModel.borderColor.uiColor, self.theme.colors.base.outline.uiColor)
        XCTAssertEqual(viewModel.backgroundColor.uiColor, self.theme.colors.base.surface.uiColor)
    }

    func test_publishers_changed() async {
        // Given
        let viewModel = TextEditorViewModel(
            theme: self.theme,
            intent: .neutral
        )

        let textColorPublisherMock: PublisherMock<Published<ColorToken>.Publisher> = .init(publisher: viewModel.$textColor)
        let placeholderColorPublisherMock: PublisherMock<Published<ColorToken>.Publisher> = .init(publisher: viewModel.$placeholderColor)
        let backgroundColorPublisherMock: PublisherMock<Published<ColorToken>.Publisher> = .init(publisher: viewModel.$backgroundColor)
        let borderColorPublisherMock: PublisherMock<Published<ColorToken>.Publisher> = .init(publisher: viewModel.$borderColor)
        let borderWidthPublisherMock: PublisherMock<Published<CGFloat>.Publisher> = .init(publisher: viewModel.$borderWidth)
        let borderRadiusPublisherMock: PublisherMock<Published<CGFloat>.Publisher> = .init(publisher: viewModel.$borderRadius)
        let fontPublisherMock: PublisherMock<Published<TypographyFontToken>.Publisher> = .init(publisher: viewModel.$font)
        let spacePublisherMock: PublisherMock<Published<CGFloat>.Publisher> = .init(publisher: viewModel.$horizontalSpacing)

        textColorPublisherMock.loadTesting(on: &cancellable)
        placeholderColorPublisherMock.loadTesting(on: &cancellable)
        backgroundColorPublisherMock.loadTesting(on: &cancellable)
        borderColorPublisherMock.loadTesting(on: &cancellable)
        borderWidthPublisherMock.loadTesting(on: &cancellable)
        borderRadiusPublisherMock.loadTesting(on: &cancellable)
        fontPublisherMock.loadTesting(on: &cancellable)
        spacePublisherMock.loadTesting(on: &cancellable)

        // When
        viewModel.theme = self.theme

        // Then
        XCTAssertPublisherSinkCountEqual(
            on: textColorPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: placeholderColorPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: borderColorPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: borderWidthPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: borderRadiusPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: fontPublisherMock,
            2
        )

        XCTAssertPublisherSinkCountEqual(
            on: spacePublisherMock,
            2
        )
    }
}
