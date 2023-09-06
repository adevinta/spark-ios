//
//  TabView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TabView: View {
    private let theme: Theme
    private let intent: TabIntent
    private let tabSize: TabSize
    @ObservedObject private var viewModel: TabViewModel
    private let content: [(image: Image?, title: String?, badge: BadgeView?)]
    @Binding var selectedIndex: Int
    @ScaledMetric var lineHeight: CGFloat

    // MARK: - Initialization
    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `main`.
    /// - tabSize: The tab size, see `TabSize`. The default value is medium `md`.
    /// - titles: An array of labels.
    public init(theme: Theme,
                intent: TabIntent = .basic,
                tabSize: TabSize = .md,
                titles: [String],
                selectedIndex: Binding<Int>
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  content: titles.map{ (nil, $0, nil) },
                  selectedIndex: selectedIndex)
    }

    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `main`.
    /// - tabSize: The tab size, see `TabSize`. The default value is medium `md`.
    /// - icons: An array of images.
    public init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
                icons: [Image],
                selectedIndex: Binding<Int>
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  content: icons.map{ ($0, nil, nil) },
                  selectedIndex: selectedIndex
        )
    }

    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `main`.
    /// - tab size: the default value is `md`.
    /// - An array of tuples of image and string.
    public init(theme: Theme,
                intent: TabIntent = .main,
                tabSize: TabSize = .md,
                content: [(Image?, String?, BadgeView?)],
                selectedIndex: Binding<Int>,
                apportionsSegmentWidthsByContent: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.content = content
        self._selectedIndex = selectedIndex
        let viewModel = TabViewModel(
            theme: theme,
            apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent,
            numberOfTabs: content.count
        )
        self._lineHeight = ScaledMetric(wrappedValue: viewModel.tabsAttributes.lineHeight)
        self.viewModel = viewModel
    }

    public var body: some View {
        self.tabItems()
            .background(self.viewModel.tabsAttributes.backgroundColor.color)
            .scrollOnOverflow(numberOfItems: self.$viewModel.numberOfTabs)
    }

    @ViewBuilder
    private func tabItems() -> some View {
        HStack {
            ForEach(Array(self.content.enumerated()), id: \.offset) { (index, content) in
                TabItemView<BadgeView>(
                    theme: self.theme,
                    intent: self.intent,
                    size: self.tabSize,
                    image: content.image,
                    title: content.title,
                    badge: content.badge,
                    apportionsSegmentWidthsByContent: self.viewModel.apportionsSegmentWidthsByContent,
                    isSelected: self.selectedIndex == index
                ) {
                    self.selectedIndex = index
                }
            }
            if self.viewModel.apportionsSegmentWidthsByContent {
                Spacer()
            }
        }
        .overlay(
            Rectangle()
                .frame(width: nil, height: self.lineHeight, alignment: .top)
                .foregroundColor(self.viewModel.tabsAttributes.lineColor.color),
            alignment: .bottom)
    }


    public func apportionsSegmentWidthsByContent(_ value: Bool) -> Self {
        self.viewModel.apportionsSegmentWidthsByContent = value
        return self
    }
}
