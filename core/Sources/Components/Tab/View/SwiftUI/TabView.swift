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
    private let content: [(image: Image?, title: String?)]
    @Binding var selectedIndex: Int

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
                  content: titles.map{ (nil, $0) },
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
                  content: icons.map{ ($0, nil) },
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
                content: [(Image?, String?)],
                selectedIndex: Binding<Int>
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.content = content
        self._selectedIndex = selectedIndex
        self.viewModel = TabViewModel(theme: theme, apportionsSegmentWidthsByContent: false)
    }

    public var body: some View {
        HStack {
            ForEach(Array(self.content.enumerated()), id: \.offset) { (index, content) in
                TabItemView<BadgeView>(
                    theme: self.theme,
                    intent: self.intent,
                    size: self.tabSize,
                    image: content.image,
                    title: content.title,
                    isSelected: self.selectedIndex == index
                )
            }
        }
        .background(self.viewModel.tabsAttributes.backgroundColor.color)
    }
}
