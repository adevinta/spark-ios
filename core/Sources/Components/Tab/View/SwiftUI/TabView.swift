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
    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding var selectedIndex: Int
    @ScaledMetric var lineHeight: CGFloat
    @State var minWidth: CGFloat = 0

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
                  content: titles.map{ .init(image: nil, title: $0, badge: nil) },
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
                  content: icons.map{ .init(image: $0, title: nil, badge: nil) },
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
                content: [TabItemContent],
                selectedIndex: Binding<Int>,
                apportionsSegmentWidthsByContent: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self._selectedIndex = selectedIndex
        let viewModel = TabViewModel(
            theme: theme,
            apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent,
            content: content
        )
        self._lineHeight = ScaledMetric(wrappedValue: viewModel.tabsAttributes.lineHeight)
        self.viewModel = viewModel
    }

    public var body: some View {
        self.tabItems()
            .scrollOnOverflow(value: self.$viewModel.content)
            .background(
                Rectangle()
                    .frame(width: nil, height: self.lineHeight, alignment: .bottom)
                    .foregroundColor(self.viewModel.tabsAttributes.lineColor.color),
                alignment: .bottom)
    }

    @ViewBuilder
    private func tabItems() -> some View {
        ScrollViewReader { proxy in
            HStack {
                ForEach(Array(self.viewModel.content.enumerated()), id: \.offset) { (index, content) in
                    self.tabContent(index: index, content: content, proxy: proxy)
                }
                if self.viewModel.apportionsSegmentWidthsByContent {
                    Spacer()
                }
            }
        }
    }

    public func apportionsSegmentWidthsByContent(_ value: Bool) -> Self {
        self.viewModel.apportionsSegmentWidthsByContent = value
        return self
    }

    @ViewBuilder
    private func tabContent(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
        if self.viewModel.apportionsSegmentWidthsByContent {
            tabItem(index: index, content: content, proxy: proxy)
                .id("Tab \(index )\(content.id)")
        } else {
            tabItem(index: index, content: content, proxy: proxy)
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                self.updateMinWidth(geometry.size.width, index: index)
                            }
                            .onChange(of: self.viewModel.content) { _ in
                                self.updateMinWidth(geometry.size.width, index: index)
                            }
                    }
                }
                .id("Tab \(index )\(content.id)")
                .frame(minWidth: self.minWidth)
        }
    }

    private func updateMinWidth(_ width: CGFloat, index: Int) {
        if index == self.viewModel.numberOfTabs - 1 {
            self.minWidth = width
        } else {
            self.minWidth = max(self.minWidth,width)
        }
    }

    @ViewBuilder
    private func tabItem(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
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
            withAnimation{
                proxy.scrollTo(index)
            }
        }
        .disabled(self.viewModel.disabledTabs[index])
    }

    public func disabled(_ disabled: Bool, index: Int) -> Self {
        self.viewModel.disableTab(disabled, index: index)
        return self
    }

    public func disabled(_ disabled: Bool) -> Self {
        self.viewModel.isEnabled = !disabled
        return self
    }
}
