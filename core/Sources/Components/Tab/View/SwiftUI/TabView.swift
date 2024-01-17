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

    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding private var selectedIndex: Int
    @ScaledMetric private var factor: CGFloat = 1.0
    @State private var minItemWidth: CGFloat = 40.0
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var appeared: Bool = false
    @State private var axis: Axis.Set = .horizontal
    @State private var apportionsContentWidth: CGFloat = 0

    private var tabsWidth: CGFloat {
        return self.minItemWidth * CGFloat(self.viewModel.content.count) * self.factor
    }

    private var lineHeight: CGFloat {
        return self.viewModel.tabsAttributes.lineHeight * self.factor
    }

    private var itemHeight: CGFloat {
        return self.viewModel.tabsAttributes.itemHeight * self.factor
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
                        .frame(height: self.lineHeight)
                        .frame(width: geometry.size.width)
                        .foregroundColor(self.viewModel.tabsAttributes.lineColor.color)
                        .onAppear {
                            self.screenWidth = geometry.size.width
                            if self.viewModel.apportionsSegmentWidthsByContent {
                                if self.apportionsContentWidth > self.screenWidth {
                                    self.axis = .horizontal
                                } else {
                                    self.axis = []
                                }
                            } else {
                                self.minItemWidth = geometry.size.width / CGFloat(self.viewModel.content.count)
                                print("MINWIDTH a \(self.minItemWidth) / \(self.screenWidth)")
                            }
                        }
                        .onChange(of: geometry.size.width) { width in
                            self.screenWidth = width
                            if self.viewModel.apportionsSegmentWidthsByContent {
                                if self.apportionsContentWidth > self.screenWidth {
                                    self.axis = .horizontal
                                } else {
                                    self.axis = []
                                }
                            } else {
                                self.minItemWidth = width / CGFloat(self.viewModel.content.count)
                                print("MINWIDTH c \(self.minItemWidth) / \(self.screenWidth)")
                            }
                        }
                }
                .frame(height: self.itemHeight)
            }

            ScrollView(self.axis, showsIndicators: false) {
                if self.viewModel.apportionsSegmentWidthsByContent {
                    self.tabItems()
                        .frame(height: self.itemHeight)
                        .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
                } else {
                    self.tabItems()
                        .frame(height: self.itemHeight)
                        .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
                }
            }
            .frame(height: self.itemHeight)
            .onChange(of: self.viewModel.content) { content in
                self.minItemWidth = self.screenWidth / CGFloat(content.count)
            }
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
                if self.viewModel.apportionsSegmentWidthsByContent {
                    Color.clear
                        .onAppear {
                            print("ITEM APPEAR \(geometry.size)")
                            self.updateApportionsContentWidth(geometry.size.width, index: index)
                        }
                        .onChange(of: geometry.size) { size in
                            print("ITEM CHANGE \(size)")
                            self.updateApportionsContentWidth(geometry.size.width, index: index)
                        }
                } else {
                    Color.clear
                        .onAppear {
                            self.updateMinWidth(geometry.size.width, index: index)
                        }
                        .onChange(of: geometry.size) { size in
                            self.updateMinWidth(geometry.size.width, index: index)
                        }
                }
            }
        }
    }

    private func updateApportionsContentWidth(_ width: CGFloat, index: Int) {
        if index == self.viewModel.content.count - 1 {
            self.apportionsContentWidth = width
        } else {
            self.apportionsContentWidth += width
        }
        print("A WIDTH \(index) = \(self.apportionsContentWidth) / \(width) (\(self.screenWidth)")
        self.axis = self.apportionsContentWidth > self.screenWidth ? .horizontal : []
    }

    private func updateMinWidth(_ width: CGFloat, index: Int) {
        print("WIDTHS old: \(self.minItemWidth) new: \(width) tabs: \(self.tabsWidth) > screen: \(self.screenWidth)")
        self.minItemWidth = max(self.minItemWidth,width)
        self.axis = floor(self.tabsWidth) > self.screenWidth ? .horizontal : []
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
