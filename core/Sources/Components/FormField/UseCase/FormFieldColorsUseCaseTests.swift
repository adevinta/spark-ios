//
//  FormFieldColorsUseCaseTests.swift
//  SparkCore
//
//  Created by alican.aycil on 26.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class FormFieldColorsUseCaseTests: XCTestCase {

    var sut: FormFieldColorsUseCase!
    var theme: ThemeGeneratedMock!

    override func setUp() {
        super.setUp()

        self.sut = .init()
        self.theme = .mocked()
    }

    // MARK: - Tests

    func test_execute_for_all_feedback_cases() {
        let feedbacks = FormFieldFeedbackState.allCases

        feedbacks.forEach {

            let formfieldColors = sut.execute(from: theme, feedback: $0)

            let expectedFormfieldColor: FormFieldColors

            switch $0 {
            case .default:
                expectedFormfieldColor = FormFieldColors(
                    title: theme.colors.base.onSurface,
                    description: theme.colors.base.onSurface.opacity(theme.dims.dim1),
                    asterisk: theme.colors.base.onSurface.opacity(theme.dims.dim1)
                )
            case .error:
                expectedFormfieldColor = FormFieldColors(
                    title: theme.colors.base.onSurface,
                    description: theme.colors.feedback.error,
                    asterisk: theme.colors.base.onSurface.opacity(theme.dims.dim1)
                )
            }

            XCTAssertEqual(formfieldColors.title.uiColor, expectedFormfieldColor.title.uiColor)
            XCTAssertEqual(formfieldColors.description.uiColor, expectedFormfieldColor.description.uiColor)
            XCTAssertEqual(formfieldColors.asterisk.uiColor, expectedFormfieldColor.asterisk.uiColor)
        }
    }
}
