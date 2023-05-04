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

        colors.base = ColorsBaseGeneratedMock.mocked()
        colors.primary = ColorsPrimaryGeneratedMock.mocked()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()
        theme.colors = colors
        theme.dims = DimsGeneratedMock.mocked()

        return theme
    }
}

private extension SelectButtonState {
    var message: String? {
        switch self {
        case .success(let message), .warning(let message), .error(let message):
            return message
        default:
            return nil
        }
    }
}
