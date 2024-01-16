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
    private let intent: TabIntent

    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding private var selectedIndex: Int
//    @ScaledMetric private var lineHeight: CGFloat
    @ScaledMetric private var factor: CGFloat = 1.0
    @State private var minItemWidth: CGFloat = 40.0
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var appeared: Bool = false
    @State private var axis: Axis.Set = .horizontal
    private var tabsWidth: CGFloat {
        return self.minItemWidth * CGFloat(self.viewModel.content.count) * self.factor
    }

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
        self.intent = intent
        self._selectedIndex = selectedIndex
        let viewModel = TabViewModel(
            theme: theme,
            apportionsSegmentWidthsByContent: false,
            content: content, 
            tabSize: tabSize
        )
        self.viewModel = viewModel
    }

    // MARK: - View
    public var body: some View {
//        let contentWidth = self.minWidth * CGFloat(self.viewModel.content.count)
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                VStack(alignment: .trailing) {
                    Spacer()
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: self.viewModel.tabsAttributes.lineHeight * self.factor)
                        .frame(width: geometry.size.width)
//                        .foregroundColor(self.viewModel.tabsAttributes.lineColor.color)
                        .foregroundColor(.red)
                        .onAppear {
                            self.screenWidth = geometry.size.width
                            self.minItemWidth = geometry.size.width / CGFloat(self.viewModel.content.count)
                            print("MINWIDTH a \(self.minItemWidth) / \(self.screenWidth)")
                        }
                        .onChange(of: geometry.size.width) { width in
                            self.screenWidth = width
                            self.minItemWidth = width / CGFloat(self.viewModel.content.count)
                            print("MINWIDTH c \(self.minItemWidth) / \(self.screenWidth)")
                        }
                }
                .frame(height: self.factor * self.viewModel.tabsAttributes.itemHeight)
            }
            ScrollView(self.axis, showsIndicators: false) {
                self.tabItems()
                    .frame(height: self.factor * self.viewModel.tabsAttributes.itemHeight)
                    .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
                    .onChange(of: self.viewModel.content) { content in
                        self.minItemWidth = self.screenWidth / CGFloat(content.count)
                    }
            }
            .frame(height: self.factor * self.viewModel.tabsAttributes.itemHeight)

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
                .frame(minWidth: self.minItemWidth)
        }
    }

    private func updateMinWidth(_ width: CGFloat, index: Int) {
        print("WIDTHS old: \(self.minItemWidth) new: \(width) tabs: \(self.tabsWidth) > screen: \(self.screenWidth)")
        self.minItemWidth = max(self.minItemWidth,width)
        self.axis = floor(self.tabsWidth) > self.screenWidth ? .horizontal : []
    }

    @ViewBuilder
    private func tabItem(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
        TabItemView(
            theme: self.viewModel.theme,
            intent: self.intent,
            size: self.viewModel.tabSize,
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
                        print("x SIZE \(geometry.size)")
                        self.updateMinWidth(geometry.size.width, index: index)
                    }
//                    .onChange(of: self.viewModel.content) { _ in
//                        print("x ContentChange \(geometry.size)")
//                        self.updateMinWidth(geometry.size.width, index: index)
//                    }
                    .onChange(of: geometry.size) { size in
                        print("y SIZE \(size) / \(self.minItemWidth)")
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

extension CGFloat {
    var des: String {
        String(format: "%.2f", self)
    }
}
