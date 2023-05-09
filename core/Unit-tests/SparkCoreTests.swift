//
//  SparkCoreTests.swift
//  SparkCoreTests
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI

final class SparkCoreUITests: UIKitComponentTestCase {
    func testExample() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        view.backgroundColor = .red
        sparktAssertSnapshot(matching: view, as: .image)
    }

    func testDynamicContentSize() throws {
        let view = UILabel()
        view.text = "Hello world"
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        assertSnapshotInDarkAndLight(matching: view)
    }
}

// MARK: - SwiftUI snapshot example
final class SparkCoreTests: SwiftUIComponentTestCase {
    func testDynamicContentSize() throws {
        let view = Text("Hello world").fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }
}
