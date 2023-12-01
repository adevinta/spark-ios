//
//  TextFieldGetSpacingsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Jacklyn Situmorang on 17.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class TextFieldGetSpacingsUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_for_none() {
        self.testExecute(
            givenBorderStyle: .none,
            expectedSpacings: .init(
                left: self.themeMock.layout.spacing.large,
                content: self.themeMock.layout.spacing.medium,
                right: self.themeMock.layout.spacing.large
            )
        )
    }

    func text_execute_for_roundedRect() {
        self.testExecute(
            givenBorderStyle: .roundedRect,
            expectedSpacings: .init(
                left: self.themeMock.layout.spacing.large,
                content: self.themeMock.layout.spacing.medium,
                right: self.themeMock.layout.spacing.large
            )
        )
    }
}

private extension TextFieldGetSpacingsUseCaseTests {
    func testExecute(
        givenBorderStyle: TextFieldBorderStyle,
        expectedSpacings: TextFieldSpacings
    ) {
        // GIVEN
        let useCase = TextFieldGetSpacingsUseCase()

        // WHEN
        let spacings = useCase.execute(
            theme: self.themeMock,
            borderStyle: givenBorderStyle
        )

        // THEN
        XCTAssertEqual(spacings.content, expectedSpacings.content)
        XCTAssertEqual(spacings.left, expectedSpacings.left)
        XCTAssertEqual(spacings.right, expectedSpacings.right)
    }
}
