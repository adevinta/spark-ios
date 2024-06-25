//
//  IconButtonSUIViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 15/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class IconButtonSUIViewModelTests: XCTestCase {

    // MARK: - Init Tests

    func test_default_properties_on_init() {
        // GIVEN / WHEN
        let viewModel = IconButtonSUIViewModel(
            theme: ThemeGeneratedMock.mocked(),
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )

        // THEN
        XCTAssertEqual(
            viewModel.controlStatus,
            .init(),
            "Wrong constrol status"
        )
        XCTAssertNotNil(
            viewModel.controlStateImage,
            "Wrong constrol state text"
        )
        XCTAssertNil(
            viewModel.controlStateText,
            "Wrong constrol state text"
        )
    }
}
