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

        var isTextColorCallCount = 0
        var isPlaceholderColorCallCount = 0
        var isBackgroundColorCallCount = 0
        var isBorderColorCallCount = 0
        var isBorderWidthCallCount = 0
        var isBorderRadiusCallCount = 0
        var isFontCallCount = 0
        var isSpaceCallCount = 0

        let predicate = NSPredicate { _, _ in
            return isTextColorCallCount == 2 &&
            isPlaceholderColorCallCount == 2 &&
            isBackgroundColorCallCount == 2 &&
            isBorderColorCallCount == 2 &&
            isBorderWidthCallCount == 2 &&
            isBorderRadiusCallCount == 2 &&
            isFontCallCount == 2 &&
            isSpaceCallCount == 2
        }

        let expectation = expectation(for: predicate, evaluatedWith: viewModel)

        viewModel.$textColor.sink { _ in
            isTextColorCallCount += 1
        }.store(in: &cancellable)

        viewModel.$placeholderColor.sink { _ in
            isPlaceholderColorCallCount += 1
        }.store(in: &cancellable)

        viewModel.$backgroundColor.sink { _ in
            isBackgroundColorCallCount += 1
        }.store(in: &cancellable)

        viewModel.$borderColor.sink { _ in
            isBorderColorCallCount += 1
        }.store(in: &cancellable)

        viewModel.$borderWidth.sink { _ in
            isBorderWidthCallCount += 1
        }.store(in: &cancellable)

        viewModel.$borderRadius.sink { _ in
            isBorderRadiusCallCount += 1
        }.store(in: &cancellable)

        viewModel.$horizontalSpacing.sink { _ in
            isSpaceCallCount += 1
        }.store(in: &cancellable)

        viewModel.$font.sink { _ in
            isFontCallCount += 1
        }.store(in: &cancellable)

        // When
        viewModel.theme = self.theme

        await fulfillment(of: [expectation], timeout: 3.0)
    }
}
