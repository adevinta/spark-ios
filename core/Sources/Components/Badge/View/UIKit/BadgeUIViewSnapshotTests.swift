//
//  BadgeUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by alex.vecherov on 22.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore

private struct TestBadgeFormatting: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "No Value"
        }
        return "Test Value \(value)"
    }
}

final class BadgeUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    private let theme: Theme = SparkTheme()

    func test_badge_all_cases_no_text() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    isBorderVisible: bool)

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_\(badgeIntent)_isBorderVisible_\(bool)")
            }
        }
    }

    func test_badge_all_cases_text() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    value: 23,
                    isBorderVisible: bool
                )

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntent)_isBorderVisible_\(bool)")
            }
        }
    }

    func test_badge_all_cases_text_small_size() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    size: .small,
                    value: 23,
                    isBorderVisible: bool
                )

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_with_text_\(badgeIntent)_small_size_isBorderVisible_\(bool)")
            }
        }
    }

    func test_badge_all_cases_text_overflow_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    value: 23,
                    format: .overflowCounter(maxValue: 20),
                    isBorderVisible: bool
                )

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_overflow_format_text_\(badgeIntent)_isBorderVisible_\(bool)")
            }
        }
    }

    func test_badge_all_cases_text_custom_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    value: 23,
                    format: .custom(
                        formatter: TestBadgeFormatting()
                    ),
                    isBorderVisible: bool
                )

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_text_\(badgeIntent)_isBorderVisible_\(bool)")
            }
        }
    }

    func test_badge_all_cases_no_text_custom_format() throws {
        for badgeIntent in BadgeIntentType.allCases {
            [true, false].forEach { bool in
                let view = BadgeUIView(
                    theme: theme,
                    intent: badgeIntent,
                    format: .custom(
                        formatter: TestBadgeFormatting()
                    ),
                    isBorderVisible: bool
                )

                assertSnapshotInDarkAndLight(matching: view, named: "test_badge_custom_format_no_text_\(badgeIntent)_isBorderVisible_\(bool)")
            }
        }
    }

    // MARK: - Attach(to:, position:)

    private func createAttachTestView(badge: BadgeUIView, position: BadgePosition) -> UIView {
        let containerView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 200))
        containerView.backgroundColor = self.theme.colors.main.mainContainer.uiColor
        let view = UIView(frame: .init(x: 50, y: 50, width: 100, height: 100))
        view.backgroundColor = self.theme.colors.main.main.uiColor
        view.layer.cornerRadius = self.theme.border.radius.small
        containerView.addSubview(view)
        containerView.addSubview(badge)
        badge.attach(to: view, position: position)
        return containerView
    }

    func test_badge_attach_no_text() throws {
        for size in BadgeSize.allCases {
            for position in BadgePosition.allCases {
                [true, false].forEach { bool in
                    let badge = BadgeUIView(theme: self.theme,
                                            intent: .alert,
                                            size: size,
                                            isBorderVisible: bool)
                    let view = self.createAttachTestView(badge: badge,
                                                         position: position)
                    assertSnapshotInDarkAndLight(matching: view, named: "test_badge_attach_no_text_\(size)_\(position)_isBorderVisible_\(bool)")
                }
            }
        }
    }

    func test_badge_attach_text() throws {
        for size in BadgeSize.allCases {
            for position in BadgePosition.allCases {
                [true, false].forEach { bool in
                    let badge = BadgeUIView(theme: self.theme,
                                            intent: .success,
                                            size: size,
                                            value: 23,
                                            isBorderVisible: bool)
                    let view = self.createAttachTestView(badge: badge,
                                                         position: position)
                    assertSnapshotInDarkAndLight(matching: view, named: "test_badge_attach_text_\(size)_\(position)_isBorderVisible_\(bool)")
                }
            }
        }
    }

    func test_badge_attach_large_text() throws {
        for size in BadgeSize.allCases {
            for position in BadgePosition.allCases {
                [true, false].forEach { bool in
                    let badge = BadgeUIView(theme: self.theme,
                                            intent: .danger,
                                            size: size,
                                            value: 23000,
                                            isBorderVisible: bool)
                    let view = self.createAttachTestView(badge: badge,
                                                         position: position)
                    assertSnapshotInDarkAndLight(matching: view, named: "test_badge_attach_large_text_\(size)_\(position)_isBorderVisible_\(bool)")
                }
            }
        }
    }
}
