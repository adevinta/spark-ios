//
//  TabsGetAttributesUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 01.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabsGetAttributesUseCaseTests: XCTestCase {

    // MARK: - Properties
    var sut: TabsGetAttributesUseCase!
    var theme: Theme!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked(
            lineHeight: 5.0,
            lineColor: .red,
            backgroundColor: .green,
            opacity: 0.1
        )

        self.sut = TabsGetAttributesUseCase()
    }

    // MARK: - Tests
    func test_execute_enabled() {

        let expectedAttributes = TabsAttributes(
            lineHeight: 5,
            lineColor: ColorTokenGeneratedMock(uiColor: .red),
            backgroundColor: ColorTokenDefault.clear
        )

        let attributes = self.sut.execute(theme: self.theme, isEnabled: true)


        XCTAssertEqual(attributes, expectedAttributes)
    }

    func test_execute_disabled() {

        let attributes = self.sut.execute(theme: self.theme, isEnabled: false)

        XCTAssertEqual(attributes.lineColor.uiColor, .red.withAlphaComponent(0.1), "Expect line to have an opacity.")
        XCTAssertEqual(attributes.backgroundColor.uiColor, .clear, "Expect background to remain the same.")
    }
}

// MARK: - Setup Mocks
private extension ThemeGeneratedMock {
    static func mocked(lineHeight: CGFloat,
                       lineColor: UIColor,
                       backgroundColor: UIColor,
                       opacity: CGFloat
    ) -> ThemeGeneratedMock{
        let border = BorderGeneratedMock()
        let width = BorderWidthGeneratedMock()
        width.small = 5
        border.width = width

        let colors = ColorsGeneratedMock()
        let base = ColorsBaseGeneratedMock()
        let surface = ColorTokenGeneratedMock(uiColor: backgroundColor)
        let outline = ColorTokenGeneratedMock(uiColor: lineColor)
        base.surface = surface
        base.outline = outline
        colors.base = base

        let dims = DimsGeneratedMock()
        dims.dim3 = opacity

        let theme = ThemeGeneratedMock()
        theme.border = border
        theme.colors = colors
        theme.dims = dims

        return theme
    }
}
