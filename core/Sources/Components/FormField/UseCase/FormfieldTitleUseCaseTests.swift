//
//  FormfieldTitleUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by alican.aycil on 10.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class FormFieldTitleUseCaseTests: XCTestCase {

    var sut: FormFieldTitleUseCase!
    var theme: ThemeGeneratedMock!

    override func setUp() {
        super.setUp()

        self.sut = .init()
        self.theme = .mocked()
    }

    // MARK: - Tests

    func test_execute_title_required_cases() {
        let isTitleRequireds = [true, false]
        let titleUseCase = FormFieldColorsUseCase()

        isTitleRequireds.forEach { isTitleRequired in

            let formfieldTitle = sut.execute(
                title: NSAttributedString(string: "Agreement"),
                isTitleRequired: isTitleRequired,
                colors: titleUseCase.execute(
                    from: self.theme,
                    feedback: .default
                ),
                typography: self.theme.typography
            )
            let formfieldTitleString = (formfieldTitle as? NSAttributedString)?.string ?? ""

            if isTitleRequired {
                XCTAssertEqual(formfieldTitleString, "Agreement *")
            } else {
                XCTAssertEqual(formfieldTitleString, "Agreement")
            }
        }
    }
}
