//
//  ChipUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ChipUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: Tests
    func test_variants_without_icon() {
        for intent in ChipIntent.allCases {
            for variant in ChipVariant.allCases {
                let chipView = ChipUIView(theme: SparkTheme.shared,
                                          intent: intent,
                                          variant: variant,
                                          label: "Label")

                assertSnapshot(of: chipView, testName: "\(#function)-\(intent)-\(variant)")
            }
        }
    }

    func test_main_with_icon_without_label() {
        for variant in ChipVariant.allCases {
            let icon: UIImage = UIImage(systemName: "pencil.circle")!
            let chipView = ChipUIView(theme: SparkTheme.shared,
                                      intent: .main,
                                      variant: variant,
                                      iconImage: icon)

            assertSnapshot(of: chipView, testName: "\(#function)-\(variant)")
        }
    }

    func test_support_with_icon_and_label() {
        for variant in ChipVariant.allCases {
            let icon: UIImage = UIImage(systemName: "pencil.circle")!
            let chipView = ChipUIView(theme: SparkTheme.shared,
                                      intent: .support,
                                      variant: variant,
                                      label: "Label",
                                      iconImage: icon)

            assertSnapshot(of: chipView, testName: "\(#function)-\(variant)")
        }
    }

    func test_support_with_icon_trailing_and_label() {
        let icon: UIImage = UIImage(systemName: "pencil.circle")!
        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: .support,
                                  variant: .filled,
                                  alignment: .trailingIcon,
                                  label: "Label",
                                  iconImage: icon)

        assertSnapshot(of: chipView, sizes: [.medium])
    }

    func test_basic_disabled_with_icon_trailing_and_label() {
        let icon: UIImage = UIImage(systemName: "pencil.circle")!
        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: .basic,
                                  variant: .filled,
                                  alignment: .trailingIcon,
                                  label: "Label",
                                  iconImage: icon)
        chipView.isEnabled = false

        assertSnapshot(of: chipView, sizes: [.medium])
    }

    func test_info_with_icon_and_label_and_component() {
        for variant in ChipVariant.allCases {
            let icon = UIImage(systemName: "pencil.circle")!

            let chipView = ChipUIView(theme: SparkTheme.shared,
                                      intent: .info,
                                      variant: variant,
                                      label: "Label",
                                      iconImage: icon)
            chipView.component = UIImageView(image: .add)

            assertSnapshot(of: chipView, testName: "\(#function)-\(variant)")
        }
    }
}
