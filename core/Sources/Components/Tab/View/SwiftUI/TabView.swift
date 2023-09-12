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
            .background(self.viewModel.tabsAttributes.backgroundColor.color)
            .scrollOnOverflow(numberOfItems: self.$viewModel.numberOfTabs)
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
            .background(
                Rectangle()
                    .frame(width: nil, height: self.lineHeight, alignment: .top)
                    .foregroundColor(self.viewModel.tabsAttributes.lineColor.color),
                alignment: .bottom)
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
        } else {
            tabItem(index: index, content: content, proxy: proxy)
                .overlay {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                print("Width \(index) \(geometry.size.width)")
                                if index == self.viewModel.numberOfTabs - 1 {
                                    self.minWidth = geometry.size.width
                                } else {
                                    self.minWidth = max(self.minWidth, geometry.size.width)
                                }
                                print("MINWIDTH (onAppear) \(self.minWidth)")

                            }
                            .onChange(of: self.viewModel.content) { _ in
                                print("MINWIDTH (onChange)\(self.minWidth)")
                                if index == self.viewModel.numberOfTabs - 1 {
                                    self.minWidth = geometry.size.width
                                } else {
                                    self.minWidth = max(self.minWidth, geometry.size.width)
                                }
                            }
                    }

                }
                .frame(minWidth: self.minWidth)
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
        .id(index)
    }
}
