//
//  UIKitComponentSnapshotTestCase.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit
import SnapshotTesting
@testable import SparkCore

open class UIKitComponentSnapshotTestCase: SnapshotTestCase {

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants
    private typealias Helpers = ComponentSnapshotTestHelpers

    // MARK: - Snapshot Testing

    func assertSnapshot(
        matching view: @autoclosure () -> some UIView,
        named name: String? = nil,
        modes: [ComponentSnapshotTestMode],
        sizes: [UIContentSizeCategory],
        record recording: Bool = Constants.record,
        delay: TimeInterval = 0,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for mode in modes {
            for size in sizes {
                sparkAssertSnapshot(
                    matching: view(),
                    as: .wait(
                        for: delay,
                        on: .image(
                            precision: Constants.imagePrecision,
                            perceptualPrecision: Constants.imagePerceptualPrecision,
                            traits: Helpers.traitCollection(
                                mode: mode,
                                size: size
                            )
                        )
                    ),
                    named: name,
                    record: recording,
                    timeout: timeout,
                    file: file,
                    testName: Helpers.testName(
                        testName,
                        mode: mode,
                        size: size
                    ),
                    line: line
                )
            }
        }
    }
}
