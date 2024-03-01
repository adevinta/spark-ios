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
    @ObservedObject var viewModel: TabViewModel<TabItemContent>
    let intent: TabIntent
    let content: TabItemContent
    let proxy: ScrollViewProxy
    @Binding var selectedIndex: Int
    let index: Int

    var body: some View {
        TabItemView(
            theme: self.viewModel.theme,
            intent: self.intent,
            size: self.viewModel.tabSize,
            content: self.content,
            apportionsSegmentWidthsByContent: self.viewModel.apportionsSegmentWidthsByContent,
            isSelected: self.selectedIndex == self.index
        ) {
            self.selectedIndex = index
            withAnimation{
                self.proxy.scrollTo(content.id)
            }
        }
        .disabled(self.viewModel.disabledTabs[index])
        .id(content.id)
        .accessibilityIdentifier("\(TabAccessibilityIdentifier.tabItem)_\(index)")

    }
}
