//
//  SwiftUIComponentSnapshotTestCase.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit
import SnapshotTesting
@testable import SparkCore

open class SwiftUIComponentSnapshotTestCase: SnapshotTestCase {

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants
    private typealias Helpers = ComponentSnapshotTestHelpers

    // MARK: - Snapshot Testing
    
    func assertSnapshot(
        matching view: @autoclosure () -> some View,
        named name: String? = nil,
        modes: [ComponentSnapshotTestMode] = Constants.modes,
        sizes: [UIContentSizeCategory] = Constants.sizes,
        record recording: Bool = Constants.record,
        timeout: TimeInterval = Constants.timeout,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for mode in modes {
            for size in sizes {
                sparkAssertSnapshot(
                    matching: view().environment(
                        \.sizeCategory,
                         ContentSizeCategory(size) ?? .extraSmall
                    ),
                    as: .image(
                        precision: Constants.imagePrecision,
                        perceptualPrecision: Constants.imagePerceptualPrecision,
                        traits: Helpers.traitCollection(
                            mode: mode,
                            size: size
                        )
                    ),
                    named: Helpers.testName(
                        testName,
                        mode: mode,
                        size: size
                    ),
                    record: recording,
                    timeout: timeout,
                    file: file,
                    testName: testName,
                    line: line
                )
            }
        }
    }
}
