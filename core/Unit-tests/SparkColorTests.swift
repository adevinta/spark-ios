//
//  SparkColorTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
@testable import Spark

import SnapshotTesting
import SwiftUI
import XCTest

final class SparkColorTests: TestCase {
    let colors = SparkTheme.shared.colors

    func x_test_base_colors() throws {
        let mirror = Mirror(reflecting: self.colors.base)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func x_test_feedback_colors() throws {
        let mirror = Mirror(reflecting: self.colors.feedback)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func x_test_primary_colors() throws {
        let mirror = Mirror(reflecting: self.colors.primary)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func x_test_secondary_colors() throws {
        let mirror = Mirror(reflecting: self.colors.secondary)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func x_test_state_colors() throws {
        let mirror = Mirror(reflecting: self.colors.states)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    private func testAllColors(colors: [String: ColorToken], testName: String = #function) {
        for value in colors {
            let view = Spacer().background(value.value.color)
            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            vc.overrideUserInterfaceStyle = .light
            sparktAssertSnapshot(matching: vc.view, as: .image, named: value.key, testName: testName)

            vc.overrideUserInterfaceStyle = .dark
            sparktAssertSnapshot(matching: vc.view, as: .image, named: value.key + "-dark", testName: testName)
        }
    }

    private func getColors(for mirror: Mirror) -> [String: ColorToken] {
        var dictionary: [String: ColorToken] = [:]
        for child in mirror.children {
            guard let label = child.label, let color = child.value as? ColorToken else { continue }

            dictionary[label] = color
        }

        return dictionary
    }
}
