//
//  SwitchGetHeightUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetHeightUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_SwitchSize_cases() throws {
        // GIVEN / WHEN
        let items: [(givenSize: SwitchSize, expectedHeight: CGFloat)] = [
            (.small, 24),
            (.medium, 32)
        ]

        for item in items {
            let useCase = SwitchGetHeightUseCase()
            let height = useCase.execute(for: item.givenSize)

            // THEN
            XCTAssertEqual(height,
                           item.expectedHeight,
                           "Wrong height for .\(item.givenSize) case")
        }
    }
}
