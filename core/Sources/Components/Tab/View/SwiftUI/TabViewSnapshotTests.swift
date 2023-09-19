//
//  TabViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import SwiftUI
import XCTest

final class TabViewSnapshotTests: SwiftUIComponentTestCase {

    // MARK: - Properties
    let theme = SparkTheme.shared
    let names = ["paperplane", "folder", "trash", "pencil", "eraser", "scribble", "lasso"]
    var badge: BadgeView!
    var images: [Image]!
    var selectedIndex: Binding<Int>!
    var index: Int = 0

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.images = names.map{ Image.init(systemName: $0) }
        self.badge = BadgeView(theme: theme, intent: .danger, value: 99).borderVisible(false)
        self.selectedIndex = Binding(
            get: {
                return self.index
            },
            set: {
                self.index = $0
            })
    }

    // MARK: - Tests
    func test_tabs_with_icons_only() throws {
        let sut = TabView(
            theme: self.theme,
            icons: Array(self.images[0..<3]),
            selectedIndex: self.selectedIndex)
            .badge(self.badge, index: 2)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icons_only_equal_width() throws {
        let sut = TabView(
            theme: self.theme,
            icons: Array(self.images[0..<3]),
            selectedIndex: self.selectedIndex)
            .badge(self.badge, index: 2)
            .apportionsSegmentWidthsByContent(false)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_text_only() throws {
        let sut = TabView(
            theme: self.theme,
            titles: Array(self.names[0..<3].map(\.capitalized)),
            selectedIndex: self.selectedIndex)
            .badge(self.badge, index: 1)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_tabs_with_text_only_equal_width() throws {
        let sut = TabView(
            theme: self.theme,
            titles: Array(self.names[0..<2].map(\.capitalized)),
            selectedIndex: self.selectedIndex)
            .apportionsSegmentWidthsByContent(false)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_tabs_with_icon_and_text() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabItemContent.init(icon:title:))

        let sut = TabView(
            theme: self.theme,
            content: content,
            selectedIndex: self.selectedIndex)
            .badge(self.badge, index: 0)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icon_and_text_size_small() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabItemContent.init(icon:title:))

        let sut = TabView(
            theme: self.theme,
            tabSize: .sm,
            content: content,
            selectedIndex: self.selectedIndex)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_tabs_with_icon_and_text_size_xtra_small() throws {
        let content = Array(Array(zip(images, names.map(\.capitalized)))[0..<3])
            .map(TabItemContent.init(icon:title:))

        let sut = TabView(
            theme: self.theme,
            tabSize: .xs,
            content: content,
            selectedIndex: self.selectedIndex)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }

    func test_many_tabs_with_icon_and_text() throws {
        let content = Array(zip(images, names.map(\.capitalized)))
            .map(TabItemContent.init(icon:title:))

        let sut = TabView(
            theme: self.theme,
            content: content,
            selectedIndex: self.selectedIndex)
            .apportionsSegmentWidthsByContent(true)
            .background(.systemBackground)
            .frame(width: 390)
            .fixedSize()

        assertSnapshotInDarkAndLight(matching: sut, sizes: [.medium])
    }
}

extension ShapeStyle where Self == Color {
    static var systemBackground: Color { Color(uiColor: .systemBackground) }
}
