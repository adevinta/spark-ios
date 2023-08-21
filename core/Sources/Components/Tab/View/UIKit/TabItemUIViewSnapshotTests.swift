//
//  TabItemUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 02.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class TabItemUIViewSnapshotTests: UIKitComponentTestCase {

    // MARK: - Properties
    let theme = SparkTheme.shared
    var image: UIImage!
    var badge: BadgeUIView!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.badge = BadgeUIView(theme: theme, intent: .danger, isBorderVisible: false)
        self.image = UIImage(systemName: "trash")!
    }

    // MARK: - Tests
    func test_tab_with_badge() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label")

        self.badge.value = 99
        sut.badge = self.badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_selected_tab_with_intent_support() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .support,
            title: "Label")

        sut.badge = badge
        sut.isSelected = true

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_selected_tab_with_intent_main() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label")

        sut.isSelected = true
        self.badge.value = 99
        sut.badge = self.badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_with_badge_only() throws {

        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main)

        self.badge.value = 99
        sut.badge = self.badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_with_label_only() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label")

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_only() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            icon: UIImage(systemName: "paperplane"))

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_with_label_and_badge() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label")

        let badge = BadgeUIView(theme: self.theme, intent: .danger, value: 99)
        sut.badge = badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.small, .medium, .large, .extraLarge])
    }

    func test_with_icon_and_label() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label",
            icon: UIImage(systemName: "paperplane")
        )
        assertSnapshotInDarkAndLight(matching: sut, sizes: [.large])
    }

    func test_with_icon_and_badge() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            icon: UIImage(systemName: "paperplane")
        )
        let badge = BadgeUIView(theme: self.theme, intent: .danger, value: 99)
        sut.badge = badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.extraSmall])
    }

    func test_with_icon_and_label_and_badge() throws {
        let sut = TabItemUIView(
            theme: self.theme,
            intent: .main,
            title: "Label",
            icon: UIImage(systemName: "paperplane")
        )
        let badge = BadgeUIView(theme: self.theme, intent: .danger, value: 99)
        sut.badge = badge

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.small])
    }
}
