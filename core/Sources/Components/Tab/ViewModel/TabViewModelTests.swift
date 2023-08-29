//
//  TabViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 01.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import XCTest

final class TabViewModelTests: TestCase {

    // MARK: - Properties
    var useCase: TabsGetAttributesUseCaseableGeneratedMock!
    var cancellables = Set<AnyCancellable>()
    var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.useCase = TabsGetAttributesUseCaseableGeneratedMock()
        self.theme = ThemeGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_attributes_published_on_init() throws {
        // Given
        let expect = expectation(description: "Expect attributes to be set.")

        let expectedAttributes = TabsAttributes(
            lineHeight: 1,
            lineColor: ColorTokenGeneratedMock(uiColor: .red),
            backgroundColor: ColorTokenGeneratedMock(uiColor: .blue)
        )
        self.useCase.executeWithThemeAndIsEnabledReturnValue = expectedAttributes

        let sut = TabViewModel(
            theme: self.theme,
            apportionsSegmentWidthsByContent: false,
            useCase: self.useCase
        )

        var attributes: TabsAttributes?
        // When
        sut.$tabsAttributes.subscribe(in: &self.cancellables) { attrs in
            attributes = attrs
            expect.fulfill()
        }

        // Then
        wait(for: [expect], timeout: 0.1)
        XCTAssertEqual(attributes, expectedAttributes)
    }

    func test_attributes_published_on_theme_change() throws {
        // Given
        let expect = expectation(description: "Expect attributes to be set.")
        expect.expectedFulfillmentCount = 2

        let expectedAttributes = TabsAttributes(
            lineHeight: 1,
            lineColor: ColorTokenGeneratedMock(uiColor: .red),
            backgroundColor: ColorTokenGeneratedMock(uiColor: .blue)
        )
        self.useCase.executeWithThemeAndIsEnabledReturnValue = expectedAttributes

        let sut = TabViewModel(
            theme: self.theme,
            apportionsSegmentWidthsByContent: false,
            useCase: self.useCase
        )

        // When
        var attributes: TabsAttributes?
        sut.$tabsAttributes.subscribe(in: &self.cancellables) { attrs in
            attributes = attrs
            expect.fulfill()
        }

        sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [expect], timeout: 0.1)
        XCTAssertEqual(attributes, expectedAttributes)
    }

    func test_attributes_published_on_enabled_change() throws {
        // Given
        let expect = expectation(description: "Expect attributes to be set.")
        expect.expectedFulfillmentCount = 2

        let expectedAttributes = TabsAttributes(
            lineHeight: 1,
            lineColor: ColorTokenGeneratedMock(uiColor: .red),
            backgroundColor: ColorTokenGeneratedMock(uiColor: .blue)
        )
        self.useCase.executeWithThemeAndIsEnabledReturnValue = expectedAttributes

        let sut = TabViewModel(
            theme: self.theme,
            apportionsSegmentWidthsByContent: false,
            useCase: self.useCase
        )

        // When
        var attributes: TabsAttributes?
        sut.$tabsAttributes.subscribe(in: &self.cancellables) { attrs in
            attributes = attrs
            expect.fulfill()
        }

        sut.isEnabled = false

        // Then
        wait(for: [expect], timeout: 0.1)
        XCTAssertEqual(attributes, expectedAttributes)
    }

}