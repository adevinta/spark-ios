//
//  SparkColorSnapshotTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest

@testable import SparkCore

final class ColorSnapshotTests: SnapshotTestCase {
    let colors = SparkTheme.shared.colors

    func test_base_colors() throws {
        let mirror = Mirror(reflecting: self.colors.base)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func test_feedback_colors() throws {
        let mirror = Mirror(reflecting: self.colors.feedback)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func test_main_colors() throws {
        let mirror = Mirror(reflecting: self.colors.main)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func test_support_colors() throws {
        let mirror = Mirror(reflecting: self.colors.support)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    func test_state_colors() throws {
        let mirror = Mirror(reflecting: self.colors.states)
        self.testAllColors(colors: self.getColors(for: mirror))
    }

    private func testAllColors(colors: [String: any ColorToken], testName: String = #function) {
        for value in colors {
            let view = Spacer().background(value.value.color)
            let vc = UIHostingController(rootView: view)
            vc.view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            vc.overrideUserInterfaceStyle = .light
            sparkAssertSnapshot(
                matching: vc.view,
                as: .image,
                named: value.key,
                testName: testName
            )

            vc.overrideUserInterfaceStyle = .dark
            sparkAssertSnapshot(
                matching: vc.view,
                as: .image,
                named: value.key + "-dark",
                testName: testName
            )
        }
    }

    private func getColors(for mirror: Mirror) -> [String: any ColorToken] {
        var dictionary: [String: any ColorToken] = [:]
        for child in mirror.children {
            guard let label = child.label, let color = child.value as? (any ColorToken) else { continue }

            dictionary[label] = color
        }

        return dictionary
    }
}
