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
import SparkTheme
@_spi(SI_SPI) import SparkCommonSnapshotTesting

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
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .main,
                content: .init(
                    icon: Image(systemName: "paperplane"),
                    title: "Label")
        )

        let sut = TabItemView(
            viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(false)
            .badge(self.badge)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.light, .dark], sizes: [.medium])
    }

    func test_selected_tab_with_intent_main() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .main,
                content: .init(title: "Label")
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .selected(true)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.light, .dark], sizes: [.medium])
    }

    func test_with_badge_only() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .main,
                content: .init()
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .selected(true)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.light, .dark], sizes: [.medium])
    }

    func test_with_label_only() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .main,
                content: .init(title: "Label")
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.light, .dark], sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_only() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .main,
                content: .init(icon: Image(systemName: "paperplane"))
        )

        let sut = TabItemView(
            viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.light, .dark], sizes: [.medium])
    }

    func test_with_label_and_badge() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .basic,
                content: .init(title: "Label")
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .selected(true)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.dark, .light], sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_and_label() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .basic,
                content: .init(
                    icon: Image(systemName: "paperplane"),
                    title: "Label")
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(false)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.dark, .light], sizes: [.large])
    }

    func test_with_icon_and_badge() throws {
        //GIVEN
        let viewModel: TabItemViewModel<TabItemContent> =
            .init(
                theme: theme,
                intent: .basic,
                content: .init(
                    icon: Image(systemName: "paperplane"))
        )

        let sut = TabItemView(viewModel: viewModel, tapAction: {})
            .apportionsSegmentWidthsByContent(true)
            .badge(self.badge)
            .background(.systemBackground)

        //THEN
        assertSnapshot(matching: sut, modes: [.dark, .light], sizes: [.extraSmall])
    }
}
