//
//  TabView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// TabView is the similar to a SegmentControl
public struct TabView: View {
    private let theme: Theme
    private let intent: TabIntent
    private let tabSize: TabSize

    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding private var selectedIndex: Int
    @ScaledMetric private var lineHeight: CGFloat
    @State private var minWidth: CGFloat = 0
    @State private var appeared: Bool = false

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
                  content: titles.map{ .init(icon: nil, title: $0) },
                  selectedIndex: selectedIndex)
    }

    /// Initializer
    /// - Parameters:
    /// - theme: the current theme
    /// - intent: the tab intent. The default value is `main`.
    /// - tabSize: The tab size, see `TabSize`. The default value is medium `md`.
    /// - icons: An array of images.
    public init(theme: Theme,
                intent: TabIntent = .basic,
                tabSize: TabSize = .md,
                icons: [Image],
                selectedIndex: Binding<Int>
    ) {
        self.init(theme: theme,
                  intent: intent,
                  tabSize: tabSize,
                  content: icons.map{ .init(icon: $0, title: nil) },
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
                intent: TabIntent = .basic,
                tabSize: TabSize = .md,
                content: [TabItemContent] = [],
                selectedIndex: Binding<Int>
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self._selectedIndex = selectedIndex
        let viewModel = TabViewModel(
            theme: theme,
            apportionsSegmentWidthsByContent: false,
            content: content
        )
        self._lineHeight = ScaledMetric(wrappedValue: viewModel.tabsAttributes.lineHeight)
        self.viewModel = viewModel
    }

    // MARK: - View
    public var body: some View {
        self.tabItems()
            .scrollOnOverflow(value: self.$viewModel.content)
            .background(
                Rectangle()
                    .frame(width: nil, height: self.lineHeight, alignment: .bottom)
                    .foregroundColor(self.viewModel.tabsAttributes.lineColor.color),
                alignment: .bottom)
            .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
            .onChange(of: self.viewModel.content) { _ in
                self.minWidth = 0
            }
    }

    // MARK: - Private functions
    @ViewBuilder
    private func tabItems() -> some View {
        ScrollViewReader { proxy in
            HStack(spacing: 0) {
                ForEach(Array(self.viewModel.content.enumerated()), id: \.element.id) { (index, content) in
                    self.tabContent(index: index, content: content, proxy: proxy)
                }
                if self.viewModel.apportionsSegmentWidthsByContent {
                    Spacer()
                }
            }
        }
    }

    @ViewBuilder
    private func tabContent(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
        if self.viewModel.apportionsSegmentWidthsByContent {
            tabItem(index: index, content: content, proxy: proxy)
        } else {
            tabItem(index: index, content: content, proxy: proxy)
                .frame(minWidth: self.minWidth)
        }
    }

    private func updateMinWidth(_ width: CGFloat, index: Int) {
        self.minWidth = max(self.minWidth,width)
    }

    @ViewBuilder
    private func tabItem(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
        TabItemView(
            theme: self.theme,
            intent: self.intent,
            size: self.tabSize,
            content: content,
            apportionsSegmentWidthsByContent: self.viewModel.apportionsSegmentWidthsByContent,
            isSelected: self.selectedIndex == index
        ) {
            self.selectedIndex = index
            withAnimation{
                proxy.scrollTo(content.id)
            }
        }
        .disabled(self.viewModel.disabledTabs[index])
        .id(content.id)
        .accessibilityIdentifier("\(TabAccessibilityIdentifier.tabItem)_\(index)")
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
    }

    // MARK: - Public view modifiers
    /// Indicates whether the control attempts to adjust segment widths based on their content widths.
    public func apportionsSegmentWidthsByContent(_ value: Bool) -> Self {
        self.viewModel.apportionsSegmentWidthsByContent = value
        return self
    }

    /// Disable the tab of the index
    public func disabled(_ disabled: Bool, index: Int) -> Self {
        self.viewModel.disableTab(disabled, index: index)
        return self
    }

    /// Set the selected tab
    public func selected(index: Int) -> Self {
        self.selectedIndex = index
        return self
    }

    /// Change the content of the tabs
    public func content(_ content: [TabItemContent]) -> Self {
        self.viewModel.content = content
        return self
    }

    /// Add a badge of a specific tab
    public func badge(_ badge: BadgeView?, index: Int) -> Self {
        guard var content = self.viewModel.content[safe: index] else { return self }

        content.badge = badge
        self.viewModel.content[index] = content
        return self
    }
}
