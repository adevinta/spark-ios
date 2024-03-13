//
//  TabEqualSizeView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

/// TabApportionsSizeView is the similar to a SegmentControl with apportionsSegmentWidthsByContent == false.
struct TabEqualSizeView: View {
    private let intent: TabIntent

    @StateObject private var widthStates = WidthStates()
    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding private var selectedIndex: Int
    @ScaledMetric private var factor: CGFloat = 1.0
    @State private var minItemWidth: CGFloat = 40.0
    @State private var screenWidth: CGFloat = 0
    @State private var axis: Axis.Set = .horizontal

    private var tabsWidth: CGFloat {
        return self.minItemWidth * CGFloat(self.viewModel.content.count)
    }

    private var lineHeight: CGFloat {
        return self.viewModel.tabsAttributes.lineHeight * self.factor
    }

    private var itemHeight: CGFloat {
        return self.viewModel.tabsAttributes.itemHeight * self.factor
    }

    /// Initializer
    /// - Parameters:
    /// - viewModel: the view model
    /// - selectedIndex: A binding with the selected index.
    /// - tab size: the default value is `md`.
    /// - An array of tuples of image and string.
    
    init(viewModel: TabViewModel<TabItemContent>,
         intent: TabIntent,
         selectedIndex: Binding<Int>
    ) {
        self._selectedIndex = selectedIndex
        self.intent = intent
        self.viewModel = viewModel
    }

    // MARK: - View
    public var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                VStack(alignment: .trailing) {
                    Spacer()

                    TabBackgroundLine(
                        lineHeight: self.lineHeight,
                        width: geometry.size.width,
                        color: self.viewModel.tabsAttributes.lineColor.color)
                        .onAppear {
                            self.screenWidth = geometry.size.width
                            self.minItemWidth = geometry.size.width / CGFloat(self.viewModel.content.count)
                        }
                        .onChange(of: geometry.size.width) { width in
                            self.screenWidth = width
                            self.minItemWidth = self.widthStates.widths[round(width)] ?? width / CGFloat(self.viewModel.content.count)
                        }
                }
                .frame(height: self.itemHeight)
            }

            ScrollView(self.axis, showsIndicators: false) {
                self.tabItems()
                    .frame(height: self.itemHeight)
                    .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
            }
            .onChange(of: self.viewModel.content) { content in
                self.minItemWidth = self.screenWidth / CGFloat(content.count)
            }
        }
        .frame(height: self.itemHeight)
    }

    // MARK: - Private functions
    @ViewBuilder
    private func tabItems() -> some View {
        ScrollViewReader { proxy in
            HStack(spacing: 0) {
                ForEach(Array(self.viewModel.content.enumerated()), id: \.element.id) { (index, content) in
                    self.tabItem(index: index, content: content, proxy: proxy)
                        .frame(minWidth: self.minItemWidth)
                }
            }
        }
    }

    @ViewBuilder
    private func tabItem(index: Int, content: TabItemContent, proxy: ScrollViewProxy) -> some View {
        TabSingleItem(
            viewModel: self.viewModel,
            intent: self.intent,
            content: content,
            proxy: proxy,
            selectedIndex: self.$selectedIndex,
            index: index)
        .background {
            GeometryReader { geometry in
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

    private func updateMinWidth(_ width: CGFloat, index: Int) {
        self.minItemWidth = max(self.minItemWidth, width)
        self.axis = floor(self.tabsWidth) > self.screenWidth ? .horizontal : []
        self.widthStates.widths[round(self.screenWidth)] = self.minItemWidth
    }
}

private class WidthStates: ObservableObject {
    var widths: [CGFloat: CGFloat] = [:]
}
