//
//  FormFieldViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by alican.aycil on 26.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import XCTest
@testable import SparkCore

final class FormFieldViewModelTests: XCTestCase {

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
        let viewModel = FormFieldViewModel(
            theme: self.theme,
            feedbackState: .default,
            title: .left(NSAttributedString(string: "Title")),
            description: .left(NSAttributedString(string: "Description")),
            isTitleRequired: true
        )

        // Then
        XCTAssertNotNil(viewModel.theme, "No theme set")
        XCTAssertNotNil(viewModel.feedbackState, "No feedback state set")
        XCTAssertNotNil(viewModel.isTitleRequired, "No title required set")
        XCTAssertTrue(viewModel.title?.leftValue?.string.contains("*") ?? false)
        XCTAssertEqual(viewModel.title?.leftValue?.string, "Title *")
        XCTAssertEqual(viewModel.description?.leftValue?.string, "Description")
        XCTAssertEqual(viewModel.spacing, self.theme.layout.spacing.small)
        XCTAssertEqual(viewModel.titleFont.uiFont, self.theme.typography.body2.uiFont)
        XCTAssertEqual(viewModel.descriptionFont.uiFont, self.theme.typography.caption.uiFont)
        XCTAssertEqual(viewModel.titleColor.uiColor, viewModel.colors.titleColor.uiColor)
        XCTAssertEqual(viewModel.descriptionColor.uiColor, viewModel.colors.descriptionColor.uiColor)
    }

    func test_texts_right_value() {
        // Given
        let viewModel = FormFieldViewModel(
            theme: self.theme,
            feedbackState: .default,
            title: .right(AttributedString("Title")),
            description: .right(AttributedString("Description")),
            isTitleRequired: false
        )

        // Then
        XCTAssertEqual(viewModel.title?.rightValue, AttributedString("Title"))
        XCTAssertEqual(viewModel.description?.rightValue, AttributedString("Description"))
    }

    func test_isTitleRequired() async {
        // Given
        let viewModel = FormFieldViewModel(
            theme: self.theme,
            feedbackState: .default,
            title: .left(NSAttributedString("Title")),
            description: .left(NSAttributedString("Description")),
            isTitleRequired: false
        )

        let expectation = expectation(description: "Title is updated")
        expectation.expectedFulfillmentCount = 2
        var isTitleUpdated = false


        viewModel.$title.sink { title in
            isTitleUpdated = title?.leftValue?.string.contains("*") ?? false
            expectation.fulfill()
        }.store(in: &cancellable)

        // When
        viewModel.isTitleRequired = true

        await fulfillment(of: [expectation])

        // Then
        XCTAssertTrue(isTitleUpdated)
    }

    func test_set_title() {
        // Given
        let viewModel = FormFieldViewModel(
            theme: self.theme,
            feedbackState: .default,
            title: .left(NSAttributedString("Title")),
            description: .left(NSAttributedString("Description")),
            isTitleRequired: true
        )

        // When
        viewModel.setTitle(.left(NSAttributedString("Title2")))

        // Then
        XCTAssertEqual(viewModel.title?.leftValue?.string, "Title2 *")
    }

    func test_set_feedback_state() {
        // Given
        let viewModel = FormFieldViewModel(
            theme: self.theme,
            feedbackState: .default,
            title: .left(NSAttributedString("Title")),
            description: .left(NSAttributedString("Description")),
            isTitleRequired: false
        )
        
        // When
        viewModel.feedbackState = .error

        // Then
        XCTAssertEqual(viewModel.feedbackState, .error)
    }
}
