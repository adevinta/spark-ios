//
//  TabItemViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest

@testable import SparkCore

final class TabItemViewSnapshotTests: SwiftUIComponentSnapshotTestCase {
    // MARK: - Properties
    let theme = SparkTheme.shared
    var image: Image!
    var badge: BadgeView!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.badge = BadgeView(theme: theme, intent: .danger, value: 99).borderVisible(false)
        self.image = Image(systemName: "trash")
    }

    // MARK: - Tests
    func test_tab_icon_and_title_and_badge() throws {

        let sut = TabItemView(
            theme: self.theme,
            intent: .main,
            content: .init(
                icon: Image(systemName: "paperplane"),
                title: "Label")) {}
            .apportionsSegmentWidthsByContent(false)
            .badge(self.badge)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.medium])
    }

    func test_selected_tab_with_intent_main() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .main,
            content: .init(title: "Label")) {}
            .apportionsSegmentWidthsByContent(true)
            .selected(true)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.medium])
    }

    func test_with_badge_only() throws {

        let sut = TabItemView(
            theme: self.theme,
            intent: .main,
            content: .init()) {}
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .selected(true)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.medium])
    }

    func test_with_label_only() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .main,
            content: .init(title: "Label")) {}
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_only() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .main,
            content: .init(icon: Image(systemName: "paperplane"))) {}
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.medium])
    }

    func test_with_label_and_badge() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .basic,
            content: .init(title: "Label")) {}
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .selected(true)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_and_label() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .basic,
            content: .init(
                icon: Image(systemName: "paperplane"),
                title: "Label")) {}
            .apportionsSegmentWidthsByContent(false)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.large])
    }

    func test_with_icon_and_badge() throws {
        let sut = TabItemView(
            theme: self.theme,
            intent: .basic,
            content: .init(icon: Image(systemName: "paperplane"))) {}
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .background(.systemBackground)

        assertSnapshot(matching: sut, sizes: [.extraSmall])
    }
}
