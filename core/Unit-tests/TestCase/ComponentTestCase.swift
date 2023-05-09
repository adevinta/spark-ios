//
//  ComponentTestCase.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit

@testable import Spark

fileprivate enum Constants {
    static let record = false
    static let timeout: TimeInterval = 5

    static let namedSuffixForLight = "-light"
    static let namedSuffixForDark = "-dark"

    static let imagePrecision: Float = 0.98
    static let imagePerceptualPrecision: Float = 0.98
}

open class SwiftUIComponentTestCase: TestCase {

    // MARK: - Snapshot Testing

    func assertSnapshotInDarkAndLight(
        matching view: @autoclosure () -> some View,
        named name: String? = nil,
        record recording: Bool = Constants.record,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        // Dark mode testing
        sparktAssertSnapshot(
            matching: view(),
            as: .image(precision: Constants.imagePrecision,
                       perceptualPrecision: Constants.imagePerceptualPrecision,
                       traits: .darkMode),
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName + Constants.namedSuffixForDark,
            line: line
        )

        // Light mode testing
        sparktAssertSnapshot(
            matching: view(),
            as: .image(precision: Constants.imagePrecision,
                       perceptualPrecision: Constants.imagePerceptualPrecision),
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName + Constants.namedSuffixForLight,
            line: line
        )
    }
}

open class UIKitComponentTestCase: TestCase {

    // MARK: - Snapshot Testing

    func assertSnapshotInDarkAndLight(
        matching view: @autoclosure () -> some UIView,
        named name: String? = nil,
        record recording: Bool = Constants.record,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        // Dark mode testing
        sparktAssertSnapshot(
            matching: view(),
            as: .image(precision: Constants.imagePrecision,
                       perceptualPrecision: Constants.imagePerceptualPrecision,
                       traits: .darkMode),
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName + Constants.namedSuffixForDark,
            line: line
        )

        // Light mode testing
        sparktAssertSnapshot(
            matching: view(),
            as: .image(precision: Constants.imagePrecision,
                       perceptualPrecision: Constants.imagePerceptualPrecision),
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName + Constants.namedSuffixForLight,
            line: line
        )
    }
}
