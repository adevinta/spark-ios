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

    // MARK: - With IconImage Tests

    func test_execute_when_iconImage_is_set_and_containsText_is_false() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            containsText: false
        )

        // THEN
        XCTAssertTrue(isIconOnly)
    }

    func test_execute_when_iconImage_and_containsText_is_true() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: .left(imageMock),
            containsText: true
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    // MARK: - Without IconImage Tests

    func test_execute_when_image_is_nil_and_containsText_is_true() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            containsText: true
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }

    func test_execute_when_image_is_nil_and_containsText_is_false() {
        // GIVEN
        let useCase = ButtonGetIsOnlyIconUseCase()

        // WHEN
        let isIconOnly = useCase.execute(
            iconImage: nil,
            containsText: false
        )

        // THEN
        XCTAssertFalse(isIconOnly)
    }
}
