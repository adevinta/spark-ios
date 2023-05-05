//
//  ScaledUIMetricTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 05.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class ScaledUIMetricTests: XCTestCase {

    // MARK: - Properties

    @ScaledUIMetric(traitCollection: UITraitCollection(preferredContentSizeCategory: .medium)) var basicMetric: CGFloat = 11
    @ScaledUIMetric(relativeTo: .body) var bodyMetric: CGFloat = 22
    @ScaledUIMetric(relativeTo: .largeTitle) var titleMetric: CGFloat = 0
    @ScaledUIMetric var zeroMetric: CGFloat = 0
    @ScaledUIMetric var comparisonMetric: CGFloat = 10
    @ScaledUIMetric var comparisonMetricExtraLarge: CGFloat = 10

    // MARK: - Tests
    func test_property_wrapper_basic() throws {
        // Then
        XCTAssertEqual(self.basicMetric, 10.666, accuracy: 0.1, "wrong scaled value")

        // Given
        self.basicMetric = 110

        // Then
        XCTAssertEqual(self.basicMetric, 105, accuracy: 0.1, "wrong scaled value")
    }

    func test_property_wrapper_body() throws {
        // Given
        self._bodyMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge))

        // Then
        XCTAssertEqual(self.bodyMetric, 62.0, accuracy: 0.1, "wrong scaled value")

        // Given
        self._bodyMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .extraSmall))

        // Then
        XCTAssertEqual(self.bodyMetric, 19.0, accuracy: 0.1, "wrong scaled value")
    }

    func test_property_wrapper_large_title() throws {
        // Given
        titleMetric = 22
        self._titleMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge))

        // Then
        XCTAssertEqual(self.titleMetric, 37.66, accuracy: 0.1, "wrong scaled value")

        // Given
        self._titleMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .extraSmall))

        // Then
        XCTAssertEqual(self.titleMetric, 20.333, accuracy: 0.1, "wrong scaled value")
    }

    func test_property_wrapper_zero() throws {
        // Given
        self._zeroMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge))

        // Then
        XCTAssertEqual(self.zeroMetric, 0, "wrong scaled value")

        // Given
        self._zeroMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: .extraSmall))

        // Then
        XCTAssertEqual(self.zeroMetric, 0, "wrong scaled value")
    }

    /// Compares the result of SwiftUI `ScaledMetric` with the result of `ScaledUIMetric`.
    func test_property_wrapper_behaves_like_swiftui_scaled_metric() throws {
        // Given
        let size = UIContentSizeCategory.extraLarge
        self._comparisonMetric.update(traitCollection: UITraitCollection(preferredContentSizeCategory: size))

        // Then
        let expectation = expectation(description: "swiftui view did appear")

        self.givenSwiftUIView(size: ContentSizeCategory(size)!, didAppearHandler: { swiftUISize in
            XCTAssertEqual(self.comparisonMetric, swiftUISize, accuracy: 0.1, "ScaledMetric and ScaledUIMetric produce different values")

            expectation.fulfill()
        })
        // Wait for the async request to complete
        waitForExpectations(timeout: 5, handler: nil)
    }

    /// Compares the result of SwiftUI `ScaledMetric` with the result of `ScaledUIMetric`.
    func test_property_wrapper_behaves_like_swiftui_scaled_metric_extra_large() throws {
        // Given
        let size = UIContentSizeCategory.accessibilityExtraExtraExtraLarge
        self._comparisonMetricExtraLarge.update(traitCollection: UITraitCollection(preferredContentSizeCategory: size))

        // Then
        let expectation = expectation(description: "swiftui view did appear")

        self.givenSwiftUIView(size: ContentSizeCategory(size)!, didAppearHandler: { swiftUISize in
            XCTAssertEqual(self.comparisonMetricExtraLarge, swiftUISize, accuracy: 0.1, "ScaledMetric and ScaledUIMetric produce different values")

            expectation.fulfill()
        })
        // Wait for the async request to complete
        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - Helper

    private func givenSwiftUIView(size: ContentSizeCategory, didAppearHandler: @escaping ((_ value: CGFloat) -> Void)) {

        let window = UIWindow()

        let view =
            TestView(didAppearHandler: { swiftUIValue in
                didAppearHandler(swiftUIValue)
                window.removeFromSuperview()
            })
            .environment(\.sizeCategory, size)

        let viewController = UIHostingController(rootView: view)

        // Simulate the view appearance
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

// MARK: - Test view to compare with SwiftUI ScaledMetric
private struct TestView: View {
    // MARK: - Properties

    /// We have to wrap the `ScaledMetric`inside a view. Other configurations are not supported.
    @ScaledMetric var value: CGFloat = 10

    var didAppearHandler: ((_ value: CGFloat) -> Void)?

    // MARK: - Body
    var body: some View {
        EmptyView()
            .onAppear {
                self.didAppearHandler?(value)
            }
    }
}
