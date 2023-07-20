//
//  ButtonGetIsOnlyIconUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 30/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetIsOnlyIconUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let imageMock = IconographyTests.shared.switchOn
    private let textMock = "My Text"
    private let attributedText = NSAttributedString(string: "My attributed String")

    // MARK: - With IconImage Tests

    func test_execute_when_iconImage_is_set_and_others_are_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            text: nil,
            attributedText: nil
        )

        // THEN
        XCTAssertTrue(isIconOnly)
    }

    func test_execute_when_iconImage_and_text_are_set_and_attributedText_is_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            text: self.textMock,
            attributedText: nil
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_iconImage_and_attributedText_are_set_and_text_is_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            text: nil,
            attributedText: .left(self.attributedText)
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_all_are_set() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            text: self.textMock,
            attributedText: .left(self.attributedText)
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    // MARK: - Without IconImage Tests

    func test_execute_when_text_is_set_and_others_are_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            text: self.textMock,
            attributedText: nil
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_attributedText_is_set_and_others_are_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            text: nil,
            attributedText: .left(self.attributedText)
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_text_and_attributedText_are_set_and_iconImage_is_nil() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            text: self.textMock,
            attributedText: .left(self.attributedText)
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_all_are_not_set() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            text: nil,
            attributedText: nil
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }
}
