//
//  XCTest+PublisherMock.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import Combine

func XCTAssertPublisherSinkCountEqual<T: Publisher>(
    on mock: PublisherMock<T>,
    _ expression: Int,
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(
        mock.sinkCount,
        expression,
        XCTest.errorMessage(
            on: mock,
            for: .count,
            function: function,
            file: file,
            line: line
        )
    )
}

func XCTAssertPublisherSinkIsCalled<T: Publisher>(
    on mock: PublisherMock<T>,
    _ expression: Bool,
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(
        mock.sinkCalled,
        expression,
        XCTest.errorMessage(
            on: mock,
            for: .isCalled,
            function: function,
            file: file,
            line: line
        )
    )
}

func XCTAssertPublisherSinkValueEqual<T: Publisher>(
    on mock: PublisherMock<T>,
    _ expression: T.Output,
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) where T.Output: Equatable {
    XCTAssertEqual(
        mock.sinkValue,
        expression,
        XCTest.errorMessage(
            on: mock,
            for: .value,
            function: function,
            file: file,
            line: line
        )
    )
}

func XCTAssertPublisherSinkValueIdentical<T: Publisher, Z: AnyObject>(
    on mock: PublisherMock<T>,
    _ expression: Z?,
    expressionShouldBeSet: Bool = true,
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    guard (expressionShouldBeSet && expression != nil) || !expressionShouldBeSet else {
        XCTFail("\(Z.self) expression should be set")
        return
    }

    XCTAssertIdentical(
        mock.sinkValue as? Z,
        expression,
        XCTest.errorMessage(
            on: mock,
            for: .value,
            function: function,
            file: file,
            line: line
        )
    )
}

func XCTAssertPublisherSinkValueNil<T: Publisher>(
    on mock: PublisherMock<T>,
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertNil(
        mock.sinkValue,
        XCTest.errorMessage(
            on: mock,
            for: .valueNil,
            function: function,
            file: file,
            line: line
        )
    )
}

func XCTAssertPublisherSinkValuesEqual<T: Publisher>(
    on mock: PublisherMock<T>,
    _ expression: [T.Output],
    function: String = #function,
    file: StaticString = #filePath,
    line: UInt = #line
) where T.Output: Equatable {
    XCTAssertEqual(
        mock.sinkValues,
        expression,
        XCTest.errorMessage(
            on: mock,
            for: .values,
            function: function,
            file: file,
            line: line
        )
    )
}

private extension XCTest {

    // MARK: - Test Type

    enum TestingSinkType: String {
        case count
        case isCalled
        case value
        case valueNil
        case values
    }

    // MARK: - Message

    static func errorMessage<T: Publisher>(
        on mock: PublisherMock<T>,
        for type: TestingSinkType,
        function: String,
        file: StaticString,
        line: UInt
    ) -> String {
        return "Wrong \(mock.name) sink \(type.rawValue) value on \(function) function, \(file) file, line \(line)"
    }
}
