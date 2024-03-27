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
                    titleColor: theme.colors.base.onSurface,
                    descriptionColor: theme.colors.base.onSurface.opacity(theme.dims.dim1),
                    asteriskColor: theme.colors.base.onSurface.opacity(theme.dims.dim3)
                )
            case .error:
                expectedFormfieldColor = FormFieldColors(
                    titleColor: theme.colors.base.onSurface,
                    descriptionColor: theme.colors.feedback.error,
                    asteriskColor: theme.colors.base.onSurface.opacity(theme.dims.dim3)
                )
            }

            XCTAssertEqual(formfieldColors.titleColor.uiColor, expectedFormfieldColor.titleColor.uiColor)
            XCTAssertEqual(formfieldColors.descriptionColor.uiColor, expectedFormfieldColor.descriptionColor.uiColor)
            XCTAssertEqual(formfieldColors.asteriskColor.uiColor, expectedFormfieldColor.asteriskColor.uiColor)
        }
    }
}
