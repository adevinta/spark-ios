//
//  XCTest+PublisherMock.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import Combine

extension XCTest {

    // MARK: - Tests

    func XCTAssertPublisherSinkCountEqual<T: Publisher>(
        on mock: PublisherMock<T>,
        _ expression: Int
    ) {
        XCTAssertEqual(
            mock.sinkCount,
            expression,
            Self.errorMessage(on: mock, for: .count)
        )
    }

    func XCTAssertPublisherSinkIsCalled<T: Publisher>(
        on mock: PublisherMock<T>,
        _ expression: Bool
    ) {
        XCTAssertEqual(
            mock.sinkCalled,
            expression,
            Self.errorMessage(on: mock, for: .isCalled)
        )
    }

    func XCTAssertPublisherSinkValueEqual<T: Publisher>(
        on mock: PublisherMock<T>,
        _ expression: T.Output
    ) where T.Output: Equatable {
        XCTAssertEqual(
            mock.sinkValue,
            expression,
            Self.errorMessage(on: mock, for: .value)
        )
    }

    func XCTAssertPublisherSinkValueIdentical<T: Publisher, Z: AnyObject>(
        on mock: PublisherMock<T>,
        _ expression: Z?,
        expressionShouldBeSet: Bool = true
    ) {
        guard (expressionShouldBeSet && expression != nil) || !expressionShouldBeSet else {
            XCTFail("\(Z.self) expression should be set")
            return
        }

        XCTAssertIdentical(
            mock.sinkValue as? Z,
            expression,
            Self.errorMessage(on: mock, for: .value)
        )
    }

    func XCTAssertPublisherSinkValuesEqual<T: Publisher>(
        on mock: PublisherMock<T>,
        _ expression: [T.Output]
    ) where T.Output: Equatable {
        XCTAssertEqual(
            mock.sinkValues,
            expression,
            Self.errorMessage(on: mock, for: .values)
        )
    }

    // MARK: - Test Type

    private enum TestingSinkType: String {
        case count
        case isCalled
        case value
        case values
    }

    // MARK: - Message

    private static func errorMessage<T: Publisher>(
        on mock: PublisherMock<T>,
        for type: TestingSinkType
    ) -> String {
        return "Wrong \(mock.name) sink \(type.rawValue) value"
    }
}
