//
//  SwitchGetTextContentUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetTextContentUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute() throws {
        // GIVEN
        let text = "My text"
        let attributedText = NSAttributedString(string: "My attributed text")

        let useCase = SwitchGetTextContentUseCase()

        // WHEN
        let textContent = useCase.execute(
            text: text,
            attributedText: .left(attributedText)
        )

        // THEN
        XCTAssertEqual(textContent.text,
                       text,
                       "Wrong text")
        XCTAssertEqual(textContent.attributedText?.leftValue,
                       attributedText,
                       "Wrong attributedText")
    }
}
