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
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString(string: "Title"),
            description: NSAttributedString(string: "Description"),
            isTitleRequired: true
        )

        // Then
        XCTAssertNotNil(viewModel.theme, "No theme set")
        XCTAssertNotNil(viewModel.feedbackState, "No feedback state set")
        XCTAssertNotNil(viewModel.isTitleRequired, "No title required set")
        XCTAssertTrue(viewModel.title?.string.contains("*") ?? false)
        XCTAssertEqual(viewModel.title?.string, "Title *")
        XCTAssertEqual(viewModel.description?.string, "Description")
        XCTAssertEqual(viewModel.spacing, self.theme.layout.spacing.small)
        XCTAssertEqual(viewModel.titleFont.uiFont, self.theme.typography.body2.uiFont)
        XCTAssertEqual(viewModel.descriptionFont.uiFont, self.theme.typography.caption.uiFont)
        XCTAssertEqual(viewModel.titleColor.uiColor, viewModel.colors.title.uiColor)
        XCTAssertEqual(viewModel.descriptionColor.uiColor, viewModel.colors.description.uiColor)
    }

    func test_texts_right_value() {
        // Given
        let viewModel = FormFieldViewModel<AttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: AttributedString("Title"),
            description: AttributedString("Description"),
            isTitleRequired: false
        )

        // Then
        XCTAssertEqual(viewModel.title, AttributedString("Title"))
        XCTAssertEqual(viewModel.description, AttributedString("Description"))
    }

    func test_isTitleRequired() async {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            description: NSAttributedString("Description"),
            isTitleRequired: false
        )

        let expectation = expectation(description: "Title is updated")
        expectation.expectedFulfillmentCount = 2
        var isTitleUpdated = false


        viewModel.$title.sink { title in
            isTitleUpdated = title?.string.contains("*") ?? false
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
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            description: NSAttributedString("Description"),
            isTitleRequired: true
        )

        // When
        viewModel.setTitle(NSAttributedString("Title2"))

        // Then
        XCTAssertEqual(viewModel.title?.string, "Title2 *")
    }

    func test_set_feedback_state() {
        // Given
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: self.theme,
            feedbackState: .default,
            title: NSAttributedString("Title"),
            description: NSAttributedString("Description"),
            isTitleRequired: false
        )
        
        // When
        viewModel.feedbackState = .error

        // Then
        XCTAssertEqual(viewModel.feedbackState, .error)
    }
}
