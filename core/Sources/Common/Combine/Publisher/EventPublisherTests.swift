//
//  EventPublisherTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 31.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class EventPublisherTests: XCTestCase {

    // MARK: - Properties
    private var button: UIButton!
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.button = UIButton(type: .system)
    }

    // MARK: - Tests
    func test_create() throws {
        // Given
        let sut = self.button.publisher(for: .touchUpOutside)

        // Then
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.control)
        XCTAssertEqual(sut.event, .touchUpOutside)
        XCTAssertEqual(self.button.allControlEvents, [])
    }

    func test_control_event() throws {
        // Given
        let sut = self.button.publisher(for: .touchDragExit)

        // Then
        XCTAssertEqual(self.button.allControlEvents, [])

        // Given
        self.register(publisher: sut)

        // Then
        XCTAssertEqual(self.button.allControlEvents, .touchDragExit)
    }

    func test_multiple_publishers() throws {
        // Given
        let publisherTouchUpInside = self.button.publisher(for: .touchUpInside)
        let publisherTouchCancel = self.button.publisher(for: .touchCancel)

        // Then
        XCTAssertEqual(self.button.allControlEvents, [])

        // Given
        self.register(publisher: publisherTouchUpInside)
        self.register(publisher: publisherTouchCancel)

        // Then
        XCTAssertEqual(self.button.allControlEvents, [.touchUpInside, .touchCancel])
    }

    func test_cancel() throws {
        // Given
        let sut = self.button.publisher(for: .touchDragExit)
        self.register(publisher: sut)

        // Then
        XCTAssertEqual(self.button.allControlEvents, .touchDragExit)

        // Given
        self.cancellables.removeAll()

        // Then
        XCTAssertEqual(self.button.allControlEvents, [])
    }

    // MARK: - Helper

    private func register(publisher: UIControl.EventPublisher) {
        publisher
            .sink(receiveValue: { _ in })
            .store(in: &self.cancellables)
    }
}
