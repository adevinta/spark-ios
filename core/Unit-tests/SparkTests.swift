//
//  SparkTests.swift
//  SparkTests
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//

import XCTest
import SnapshotTesting

final class SparkTests: XCTestCase {

    func testExample() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        view.backgroundColor = .red
        sparktAssertSnapshot(matching: view, as: .image)
    }
}
