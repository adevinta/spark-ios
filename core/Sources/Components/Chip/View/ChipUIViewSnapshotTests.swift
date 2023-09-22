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
    typealias ChipTestVariation = IntentAndVariantSnapshotTests<ChipIntent, ChipVariant>

    let icon: UIImage = UIImage(systemName: "pencil.circle")!

    // MARK: Tests

    func test_all_intents_and_variants() {
        for variation in ChipTestVariation.allCases {
            let chipView = ChipUIView(theme: SparkTheme.shared,
                                      intent: variation.intent,
                                      variant: variation.variant,
                                      label: "Label",
                                      iconImage: self.icon)
            assertSnapshotInDarkAndLight(matching: chipView,
                                         sizes: [.medium],
                                         testName: variation.testName())
        }
    }

    func test_with_icon_and_label_all_sizes() {
        let variation = ChipTestVariation(intent: .basic, variant: .outlined)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  label: "Label",
                                  iconImage: self.icon)

        assertSnapshotInDarkAndLight(matching: chipView,
                                     testName: variation.testName())
    }

    func test_with_icon_only() {
        let variation = ChipTestVariation(intent: .main, variant: .dashed)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  iconImage: self.icon)

        assertSnapshotInDarkAndLight(matching: chipView,
                                     sizes: [.medium],
                                     testName: variation.testName())
    }

    func test_with_label_only() {
        let variation = ChipTestVariation(intent: .danger, variant: .tinted)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  label: "Label")

        assertSnapshotInDarkAndLight(matching: chipView,
                                     sizes: [.medium],
                                     testName: variation.testName())
    }

    func test_trailing_icon_and_label() {
        let variation = ChipTestVariation(intent: .accent, variant: .tinted)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  alignment: .trailingIcon,
                                  label: "Label",
                                  iconImage: self.icon)

        assertSnapshotInDarkAndLight(matching: chipView,
                                     sizes: [.medium],
                                     testName: variation.testName())
    }

    func test_disabled_icon_and_label() {
        let variation = ChipTestVariation(intent: .accent, variant: .tinted)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  alignment: .trailingIcon,
                                  label: "Label",
                                  iconImage: self.icon)
        chipView.isEnabled = false

        assertSnapshotInDarkAndLight(matching: chipView,
                                     sizes: [.medium],
                                     testName: variation.testName())
    }

    func test_with_extra_component() {
        let variation = ChipTestVariation(intent: .basic, variant: .outlined)

        let chipView = ChipUIView(theme: SparkTheme.shared,
                                  intent: variation.intent,
                                  variant: variation.variant,
                                  label: "Label",
                                  iconImage: self.icon)
        chipView.isEnabled = false
        chipView.component = UIImageView(image: .add)

        assertSnapshotInDarkAndLight(matching: chipView,
                                     sizes: [.medium],
                                     testName: variation.testName())
    }
}
