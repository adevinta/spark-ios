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
    private var viewModel: TabViewModel<TabItemContent>
    @ObservedObject private var containerViewModel = TabContainerViewModel()
    @Binding private var selectedIndex: Int
    @Environment(\.isEnabled) private var isEnabled: Bool

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
            content: content, 
            tabSize: tabSize
        )
        self.viewModel = viewModel
    }

    // MARK: - View
    public var body: some View {
        let viewModel = self.viewModel.setIsEnabled(self.isEnabled)
        
        if self.containerViewModel.apportionsSegmentWidthsByContent {
            TabApportionsSizeView(viewModel: viewModel, intent: self.intent, selectedIndex: self.$selectedIndex)
        } else {
            TabEqualSizeView(viewModel: viewModel, intent: self.intent, selectedIndex: self.$selectedIndex)
        }
    }

    // MARK: - Public view modifiers
    /// Indicates whether the control attempts to adjust segment widths based on their content widths.
    public func apportionsSegmentWidthsByContent(_ value: Bool) -> Self {
        self.containerViewModel.apportionsSegmentWidthsByContent = value
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
