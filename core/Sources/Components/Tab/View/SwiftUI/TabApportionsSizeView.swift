//
//  TabApportionsSizeView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI


/// TabApportionsSizeView is the similar to a SegmentControl with apportionsSegmentWidthsByContent == true.
struct TabApportionsSizeView: View {
    private let intent: TabIntent

    @ObservedObject private var viewModel: TabViewModel<TabItemContent>
    @Binding private var selectedIndex: Int
    @ScaledMetric private var factor: CGFloat = 1.0
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var axis: Axis.Set = .horizontal
    @State private var apportionsContentWidth: CGFloat = 0

    private var lineHeight: CGFloat {
        return self.viewModel.tabsAttributes.lineHeight * self.factor
    }

    private var itemHeight: CGFloat {
        return self.viewModel.tabsAttributes.itemHeight * self.factor
    }

    /// Initializer
    /// - Parameters:
    /// - viewModel: the current view model
    /// - intent: the tab intent.
    /// - selectedIndex: Binding of the index of the current selected tab.
    public init(viewModel: TabViewModel<TabItemContent>,
                intent: TabIntent,
                selectedIndex: Binding<Int>
    ) {
        self.intent = intent
        self._selectedIndex = selectedIndex
        self.viewModel = viewModel
    }

    // MARK: - View
    var body: some View {
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
                            self.updateAxis()
                        }
                        .onChange(of: geometry.size.width) { width in
                            self.screenWidth = width
                            self.updateAxis()
                        }
                }
                .frame(height: self.itemHeight)
            }

            ScrollView(self.axis, showsIndicators: false) {
                self.tabItems()
                    .frame(height: self.itemHeight)
                    .accessibilityIdentifier(TabAccessibilityIdentifier.tab)
            }
            .frame(height: self.itemHeight)
        }
    }

    // MARK: - Private functions
    @ViewBuilder
    private func tabItems() -> some View {
        ScrollViewReader { proxy in
            HStack(spacing: 0) {
                ForEach(Array(self.viewModel.content.enumerated()), id: \.element.id) { (index, content) in
                    self.tabItem(index: index, content: content, proxy: proxy)
                }
                Spacer()
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
            index: index)        .background {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            self.updateApportionsContentWidth(geometry.size.width, index: index)
                        }
                        .onChange(of: geometry.size) { size in
                            self.updateApportionsContentWidth(geometry.size.width, index: index)
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
        self.updateAxis()
    }

    private func updateAxis() {
        self.axis = self.apportionsContentWidth > self.screenWidth ? .horizontal : []
    }
}
