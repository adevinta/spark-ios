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
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent)

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_\(badgeIntent)")
        }
    }

    func test_badge_all_cases_text() throws {
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent,
                value: 23
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntent)")
        }
    }

    func test_badge_all_cases_text_smal_size() throws {
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent,
                size: .small,
                value: 23
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntent)_small_size")
        }
    }

    func test_badge_all_cases_text_overflow_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent,
                value: 23,
                format: .overflowCounter(maxValue: 20)
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_overflow_format_text_\(badgeIntent)")
        }
    }

    func test_badge_all_cases_text_custom_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent,
                value: 23,
                format: .custom(
                    formatter: TestBadgeFormatting()
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_text_\(badgeIntent)")
        }
    }

    func test_badge_all_cases_no_text_custom_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            let view = BadgeUIView(
                theme: theme,
                intent: badgeIntent,
                format: .custom(
                    formatter: TestBadgeFormatting()
                )
            )

            assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_no_text_\(badgeIntent)")
        }
    }
}
