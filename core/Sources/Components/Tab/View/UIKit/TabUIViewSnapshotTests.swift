//
//  TabUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class TabUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties
    let theme = SparkTheme.shared
    let names = ["paperplane", "folder", "trash", "pencil", "eraser", "scribble", "lasso"]
    var badge: BadgeUIView!
    var images: [UIImage]!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.images = names.map{ UIImage.init(systemName: $0)! }
        self.badge = BadgeUIView(theme: theme, intent: .danger, value: 99, isBorderVisible: false)
    }

    // MARK: - Tests
    func test_tabs_with_icons_only() throws {
        let sut = TabUIView(
            theme: self.theme,
            icons: Array(self.images[0..<3]),
            apportionsSegmentWidthsByContent: true
        )
        sut.setBadge(self.badge, forSegementAt: 2)
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icons_only_equal_width() throws {
        let sut = TabUIView(
            theme: self.theme,
            icons: Array(self.images[0..<3]),
            apportionsSegmentWidthsByContent: false
        )
        sut.setBadge(self.badge, forSegementAt: 2)
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_text_only() throws {
        let sut = TabUIView(
            theme: self.theme,
            titles: Array(self.names[0..<3].map(\.capitalized)),
            apportionsSegmentWidthsByContent: true
        )
        sut.setBadge(self.badge, forSegementAt: 1)
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_tabs_with_text_only_equal_width() throws {
        let sut = TabUIView(
            theme: self.theme,
            titles: Array(self.names[0..<2].map(\.capitalized)),
            apportionsSegmentWidthsByContent: false
        )
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_tabs_with_icon_and_text() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabUIItemContent.init(icon:title:))

        let sut = TabUIView(
            theme: self.theme,
            content: content,
            apportionsSegmentWidthsByContent: true
        )
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground
        sut.setBadge(self.badge, forSegementAt: 0)

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icon_and_text_size_small() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabUIItemContent.init(icon:title:))

        let sut = TabUIView(
            theme: self.theme,
            tabSize: .sm,
            content: content,
            apportionsSegmentWidthsByContent: true
        )
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icon_and_text_size_xtra_small() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabUIItemContent.init(icon:title:))

        let sut = TabUIView(
            theme: self.theme,
            tabSize: .xs,
            content: content,
            apportionsSegmentWidthsByContent: true
        )
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_many_tabs_with_icon_and_text() throws {
        let content = Array(zip(images, names.map(\.capitalized)))
            .map(TabUIItemContent.init(icon:title:))

        let sut = TabUIView(
            theme: self.theme,
            content: content,
            apportionsSegmentWidthsByContent: true
        )
        sut.maxWidth = 390
        sut.backgroundColor = UIColor.systemBackground

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }
}
