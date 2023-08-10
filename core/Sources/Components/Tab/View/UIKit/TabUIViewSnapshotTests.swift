//
//  TabUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class TabUIViewSnapshotTests: UIKitComponentTestCase {

    // MARK: - Properties
    let theme = SparkTheme.shared
    let names = ["paperplane", "folder", "trash", "pencil", "eraser", "scribble", "lasso"]
    var badge: BadgeUIView!
    var images: [UIImage]!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.images = names.map{ UIImage.init(systemName: $0)! }
        self.badge = BadgeUIView(theme: theme, intent: .danger, value: 99)
    }

    // MARK: - Tests
    func test_tabs_with_icons_only() throws {
        let sut = TabUIView(theme: self.theme, icons: Array(self.images[0..<3]))
        sut.setBadge(self.badge, forSegementAt: 2)

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_text_only() throws {
        let sut = TabUIView(
            theme: self.theme,
            texts: Array(self.names[0..<3].map(\.capitalized))
        )
        sut.setBadge(self.badge, forSegementAt: 1)

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_tabs_with_icon_and_text() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])

        let sut = TabUIView(
            theme: self.theme,
            content: content
        )
        sut.setBadge(self.badge, forSegementAt: 0)

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_many_tabs_with_icon_and_text() throws {
        let content = Array(zip(images, names.map(\.capitalized)))

        let sut = TabUIView(
            theme: self.theme,
            content: content
        )

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }
}
