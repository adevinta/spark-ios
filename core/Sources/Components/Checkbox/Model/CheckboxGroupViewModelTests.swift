//
//  CheckboxGroupViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by alican.aycil on 22.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import UIKit
import SwiftUI
@testable import SparkCore

final class CheckboxGroupViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var checkedImage = IconographyTests.shared.checkmark
    var sut: CheckboxGroupViewModel!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mock
        self.sut = CheckboxGroupViewModel(
            title: "Title",
            checkedImage: Image(uiImage: self.checkedImage),
            accessibilityIdentifierPrefix: "id",
            theme: self.theme
        )
    }

    // MARK: - Tests
    func test_init() throws {

            // Then
            XCTAssertIdentical(sut.theme as? ThemeGeneratedMock,
                               self.theme,
                               "Wrong typography value")

            XCTAssertEqual(sut.title, "Title", "text does not match")
            XCTAssertEqual(sut.checkedImage, Image(uiImage: self.checkedImage), "Checked image does not match")
            XCTAssertEqual(sut.alignment, .left, "Alignment does not match")
            XCTAssertEqual(sut.layout, .vertical, "Layout does not match")
            XCTAssertEqual(sut.intent, .main, "Intent does not match")
            XCTAssertEqual(sut.titleFont.uiFont, self.theme.typography.subhead.uiFont, "Title font does not match" )
            XCTAssertEqual(sut.titleColor.uiColor, self.theme.colors.base.onSurface.uiColor, "Title color does not match" )
            XCTAssertEqual(sut.accessibilityIdentifierPrefix, "id", "Accessibility identifier does not match" )
    }

    func test_singleCheckbox_width() throws {
            // Given
            let text = "This is the way"
            let width: CGFloat = self.calculateCheckboxWidth(string: text)

            // Then
            let viewModelWidth: CGFloat = self.sut.calculateSingleCheckboxWidth(string: text)

            XCTAssertEqual(width, viewModelWidth, "Single checkbox calculation is wrong for SwiftUI Side")
    }

    func calculateCheckboxWidth(string: String?) -> CGFloat {

        let checkboxViewModel = CheckboxViewModel(
            text: .left(NSAttributedString(string: "Text")),
            checkedImage: .left(self.checkedImage),
            theme: self.theme,
            selectionState: .selected
        )

        let spacing: CGFloat = checkboxViewModel.spacing
        let checkboxControlSize: CGFloat = CheckboxView.Constants.checkboxSize
        let font: UIFont = checkboxViewModel.font.uiFont
        let fontAttributes: [NSAttributedString.Key: Any]  = [NSAttributedString.Key.font: font]
        let textSize: CGSize? = (string as? NSString)?.size(withAttributes: fontAttributes)
        let textWidth: CGFloat = textSize?.width ?? 0
        return  checkboxControlSize + spacing + textWidth
    }
}

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()

        theme.colors =  ColorsGeneratedMock.mocked()
        theme.layout = LayoutGeneratedMock.mocked()
        theme.dims = DimsGeneratedMock.mocked()
        theme.border = BorderGeneratedMock.mocked()

        let typography = TypographyGeneratedMock()
        typography.body1 = TypographyFontTokenGeneratedMock.mocked(.systemFont(ofSize: 14))
        typography.subhead = TypographyFontTokenGeneratedMock.mocked(.subheadline)
        theme.typography = typography

        return theme
    }
}
