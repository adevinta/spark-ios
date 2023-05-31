//
//  BadgeUIViewTests.swift
//  SparkCoreTests
//
//  Created by alex.vecherov on 22.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark

private struct TestBadgeFormatting: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "No Value"
        }
        return "Test Value \(value)"
    }
}

final class BadgeUIViewTests: UIKitComponentTestCase {

    private let theme: Theme = SparkTheme()

    func test_badge_all_cases_no_text() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType)
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_\(badgeIntentType)")
        }
    }

    func test_badge_all_cases_text() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType,
                    initValue: 23
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntentType)")
        }
    }

    func test_badge_all_cases_text_smal_size() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType,
                    badgeSize: .small,
                    initValue: 23
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntentType)_small_size")
        }
    }

    func test_badge_all_cases_text_overflow_format() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType,
                    initValue: 23,
                    format: .overflowCounter(maxValue: 20)
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_overflow_format_text_\(badgeIntentType)")
        }
    }

    func test_badge_all_cases_text_custom_format() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType,
                    initValue: 23,
                    format: .custom(
                        formatter: TestBadgeFormatting()
                    )
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_text_\(badgeIntentType)")
        }
    }

    func test_badge_all_cases_no_text_custom_format() throws {
        for badgeIntentType in BadgeIntentType.allCases {
            let view = BadgeUIView(
                viewModel: BadgeViewModel(
                    theme: theme,
                    badgeType: badgeIntentType,
                    format: .custom(
                        formatter: TestBadgeFormatting()
                    )
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_no_text_\(badgeIntentType)")
        }
    }
}
