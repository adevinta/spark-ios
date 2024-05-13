//
//  TabSingleItem.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

struct TabSingleItem: View {
    let intent: TabIntent
    let content: TabItemContent
    let proxy: ScrollViewProxy
    @Binding var selectedIndex: Int
    let index: Int

    @ObservedObject private var  itemViewModel: TabItemViewModel<TabItemContent>

    init(viewModel: TabViewModel<TabItemContent>, intent: TabIntent, content: TabItemContent, proxy: ScrollViewProxy, selectedIndex: Binding<Int>, index: Int) {
        self.intent = intent
        self.content = content
        self.proxy = proxy
        self._selectedIndex = selectedIndex
        self.index = index

        self.itemViewModel = TabItemViewModel(
            theme: viewModel.theme,
            intent: intent,
            tabSize: viewModel.tabSize,
            content: content,
            apportionsSegmentWidthsByContent: viewModel.apportionsSegmentWidthsByContent
        )
        .updateState(isSelected: selectedIndex.wrappedValue == index)
        .updateState(isEnabled: viewModel.isTabEnabled(index: index))
    }

    var body: some View {
        TabItemView(viewModel: itemViewModel) {
            self.selectedIndex = self.index
            withAnimation{
                self.proxy.scrollTo(self.content.id)
            }
        }
        .disabled(!self.itemViewModel.isEnabled)
        .id(self.content.id)
        .accessibilityIdentifier("\(TabAccessibilityIdentifier.tabItem)_\(index)")
    }
}
