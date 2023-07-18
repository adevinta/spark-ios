//
//  SpinnerViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import XCTest
import SwiftUI

final class SpinnerViewModelTests: XCTestCase {

    // MARK: - Private properties
    private var useCase: GetSpinnerIntentColorUseCasableGeneratedMock!
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.useCase = GetSpinnerIntentColorUseCasableGeneratedMock()
        let colorToken = ColorTokenGeneratedMock.mock(Color.red)
        self.useCase.executeWithColorsAndIntentReturnValue = colorToken
    }

    // MARK: - Tests
    func test_variables_published_on_init() {
        let sut = sut(intent: .primary, spinnerSize: .small)
        let expect = expectation(description: "All publishers should have published")

        Publishers.Zip(sut.$intentColor, sut.$size).subscribe(in: &self.subscriptions) { (colorToken, size) in

            XCTAssertEqual(colorToken.color, Color.red)
            XCTAssertEqual(size, SpinnerViewModel.Constants.Size.small)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 0.1)
    }

    func test_non_published_variables_on_init() {
        let sut = sut(intent: .error, spinnerSize: .medium)

        XCTAssertEqual(sut.size, SpinnerViewModel.Constants.Size.medium, "Expected size to be \(SpinnerViewModel.Constants.Size.medium)")
        XCTAssertEqual(sut.intentColor.color, Color.red, "Expected intent.color to be red")
        XCTAssertEqual(sut.duration, SpinnerViewModel.Constants.duration, "Expected duration to be \(SpinnerViewModel.Constants.duration)")
        XCTAssertEqual(sut.strokeWidth, SpinnerViewModel.Constants.stroke, "Expected strokeWidth to be \(SpinnerViewModel.Constants.stroke)")
    }

    func test_colors_republished_on_theme_update() {
        let sut = sut(intent: .primary, spinnerSize: .small)
        let expect = expectation(description: "All publisher should have published")
        expect.expectedFulfillmentCount = 2

        sut.$intentColor.subscribe(in: &self.subscriptions) { colorToken in
            XCTAssertEqual(colorToken.color, Color.red)
            expect.fulfill()
        }

        sut.theme = ThemeGeneratedMock.mocked()

        wait(for: [expect], timeout: 0.1)
    }

    func test_size_republished_on_size_update() {
        let sut = sut(intent: .primary, spinnerSize: .small)
        let expect = expectation(description: "All publisher should have published")
        expect.expectedFulfillmentCount = 2

        var expectedSize = 20.0
        sut.$size.subscribe(in: &self.subscriptions) { size in
            XCTAssertEqual(size, expectedSize)
            expectedSize = 28
            expect.fulfill()
        }

        sut.spinnerSize = .medium

        wait(for: [expect], timeout: 0.1)
    }

    // MARK: - Private helper function
    private func sut(intent: SpinnerIntent, spinnerSize: SpinnerSize) -> SpinnerViewModel {
        return .init(theme: ThemeGeneratedMock.mocked(),
                     intent: intent,
                     spinnerSize: spinnerSize,
                     useCase: self.useCase
        )
    }
}
