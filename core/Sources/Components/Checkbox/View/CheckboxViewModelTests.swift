//
//  CheckboxViewModelTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class CheckboxViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var bindingValue: Int = 0
    var subscription: Cancellable?

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mock
    }

    // MARK: - Tests
    func test_opacity() throws {
        // Given
        let opacities = self.sutValues(for: \.opacity)

        // Then
        XCTAssertEqual(opacities, [0.4, 1.0, 1.0, 1.0, 1.0])
    }

    func test_interactionEnabled() {
        // Given
        let disabledStates = self.sutValues(for: \.interactionEnabled)

        // Then
        XCTAssertEqual(disabledStates, [false, true, true, true, true])
    }

    func test_supplementaryMessage() {
        // Given
        let supplementaryTexts = self.sutValues(for: \.supplementaryMessage)

        // Then
        XCTAssertEqual(supplementaryTexts, [nil, nil, "Success", "Warning", "Error"])
    }

    // MARK: - Private Helper Functions
    private func sutValues<T>(for keyPath: KeyPath<CheckboxViewModel, T>) -> [T] {
        // Given
        let statesToTest: [SelectButtonState] = [
            .disabled,
            .enabled,
            .success(message: "Success"),
            .warning(message: "Warning"),
            .error(message: "Error")
        ]

        return statesToTest
            .map(sut(state:))
            .map{ $0[keyPath: keyPath] }

    }

    private func sut(state: SelectButtonState) -> CheckboxViewModel {
        return CheckboxViewModel(text: "Text", theming: self.theme, state: state)
    }
}

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        let base = ColorsBaseGeneratedMock()
        base.outline = ColorTokenGeneratedMock()
        base.surface = ColorTokenGeneratedMock()

        let onSurface = ColorTokenGeneratedMock()
        onSurface.color = Color.red
        base.onSurface = onSurface

        let primary = ColorsPrimaryGeneratedMock()
        primary.primaryContainer = ColorTokenGeneratedMock()
        primary.primary = ColorTokenGeneratedMock()
        primary.onPrimary = ColorTokenGeneratedMock()

        let feedback = ColorsFeedbackGeneratedMock()
        feedback.success = ColorTokenGeneratedMock()
        feedback.successContainer = ColorTokenGeneratedMock()

        feedback.alert = ColorTokenGeneratedMock()
        feedback.alertContainer = ColorTokenGeneratedMock()

        feedback.error = ColorTokenGeneratedMock()
        feedback.errorContainer = ColorTokenGeneratedMock()

        colors.base = base
        colors.primary = primary
        colors.feedback = feedback

        let layout = LayoutGeneratedMock()
        let spacing = LayoutSpacingGeneratedMock()
        spacing.medium = 5
        layout.spacing = spacing

        theme.colors = colors

        let dims = DimsGeneratedMock()
        dims.dim3 = 0.4
        theme.dims = dims

        return theme
    }
}
