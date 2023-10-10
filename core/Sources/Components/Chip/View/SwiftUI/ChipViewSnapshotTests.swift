//
//  ChipViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 20.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class ChipViewSnapshotTests: SwiftUIComponentTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared
    private var icon = Image(systemName: "person.2.circle.fill")
    private let title = "Title"

    // MARK: - Tests

    func test_swiftUI_chip_with_all_intents_outlined() throws {

        let variations = ChipIntent.allCases.map{ ChipVariation(intent: $0, variant: .outlined) }

        for variation in variations {
            let view = ChipView(
                theme: self.theme,
                intent: variation.intent,
                variant: variation.variant,
                icon: self.icon,
                title: self.title
            ).fixedSize()

            self.assertSnapshotInDarkAndLight(
                matching: view,
                sizes: [.medium],
                testName: variation.testName()
            )
        }
    }

    func test_swiftUI_chip_with_all_variants_basic() throws {

        let variations = ChipVariant.allCases.map{ ChipVariation(intent: .basic, variant: $0) }

        for variation in variations {
            let view = ChipView(
                theme: self.theme,
                intent: variation.intent,
                variant: variation.variant,
                icon: self.icon,
                title: self.title
            ).fixedSize()

            self.assertSnapshotInDarkAndLight(
                matching: view,
                sizes: [.medium],
                testName: variation.testName()
            )
        }
    }

    func test_swiftUI_chip_all_sizes() throws {
        let variation = ChipVariation(intent: .basic, variant: .filled)
        let view = ChipView(
            theme: self.theme,
            intent: variation.intent,
            variant: variation.variant,
            icon: self.icon,
            title: self.title
        ).fixedSize()

        self.assertSnapshotInDarkAndLight(
            matching: view,
            testName: variation.testName()
        )
    }

    func test_swiftUI_chip_with_icon_only() throws {
        let variation = ChipVariation(intent: .info, variant: .filled)
        let view = ChipView(
            theme: self.theme,
            intent: variation.intent,
            variant: variation.variant,
            icon: self.icon
        ).fixedSize()

        self.assertSnapshotInDarkAndLight(
            matching: view,
            sizes: [.medium],
            testName: variation.testName()
        )
    }

    func test_swiftUI_chip_with_icon_and_leading_title() throws {
        let variation = ChipVariation(intent: .basic, variant: .outlined)
        let view = ChipView(
            theme: self.theme,
            intent: variation.intent,
            variant: variation.variant,
            alignment: .trailingIcon,
            title: self.title
        ).fixedSize()

        self.assertSnapshotInDarkAndLight(
            matching: view,
            sizes: [.medium],
            testName: variation.testName()
        )
    }

    func test_swiftUI_chip_with_extra_component_only() throws {
        let variation = ChipVariation(intent: .main, variant: .dashed)

        let component = AnyView(Image(systemName: "xmark.circle"))
        let view = ChipView(
            theme: self.theme,
            intent: variation.intent,
            variant: variation.variant,
            icon: self.icon,
            title: self.title
        )
        .component(component)
        .fixedSize()

        self.assertSnapshotInDarkAndLight(
            matching: view,
            sizes: [.medium],
            testName: variation.testName()
        )
    }
}

private struct ChipVariation {
    let intent: ChipIntent
    let variant: ChipVariant

    func testName(_ function: String = #function) -> String {
        return "\(function)-\(self.intent)-\(self.variant)"
    }
}
