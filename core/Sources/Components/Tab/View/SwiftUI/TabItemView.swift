//
//  TabItemView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// A single tab item used on the tab view.
public struct TabItemView: View {

    // MARK: - Private Variables
    @ObservedObject private var viewModel: TabItemViewModel<TabItemContent>

    private let tapAction: () -> Void

    // MARK: - Scaled Metrics
    @ScaledMetric private var lineHeight: CGFloat
    @ScaledMetric private var itemHeight: CGFloat
    @ScaledMetric private var iconHeight: CGFloat
    @ScaledMetric private var paddingHorizontal: CGFloat
    @ScaledMetric private var spacing: CGFloat

    // MARK: Initialization
    /// Initializer
    /// - Parameters:
    /// - theme: The current theme.
    /// - intent: The intent, the default is `basic`.
    /// - size: The tab size, the default is `md`.
    /// - content: The content of the tab.
    /// - apportionsSegmentWidthsByContent: Determins if the tab is to be as wide as it's content, or equally spaced.
    /// - tapAction: the action triggered by tapping on the tab.
    public init(
        theme: Theme,
        intent: TabIntent = .basic,
        size: TabSize = .md,
        content: TabItemContent,
        apportionsSegmentWidthsByContent: Bool = false,
        isSelected: Bool = false,
        tapAction: @escaping () -> Void
    ) {
        let viewModel = TabItemViewModel(
            theme: theme,
            intent: intent,
            tabSize: size,
            content: content,
            apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent
        )
        viewModel.isSelected = isSelected

        self.init(viewModel: viewModel,
                  tapAction: tapAction
        )
    }

    internal init(
        viewModel: TabItemViewModel<TabItemContent>,
        tapAction: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.tapAction = tapAction

        self._lineHeight = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.heights.separatorLineHeight)
        self._itemHeight = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.heights.itemHeight)
        self._iconHeight = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.heights.iconHeight)
        self._spacing = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.spacings.content)
        self._paddingHorizontal = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.spacings.horizontalEdge)
    }

    // MARK: - View
    public var body: some View {
        Button(
            action: {
                self.tapAction()
            },
            label: {
                self.tabContent()
                    .background(self.viewModel.tabStateAttributes.colors.background.color)
                    .contentShape(Rectangle())
            })
        .opacity(self.viewModel.tabStateAttributes.colors.opacity)
        .buttonStyle(TabItemButtonStyle(viewModel: self.viewModel))
        .isEnabledChanged { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
    }

    // MARK: Private Functions
    @ViewBuilder
    private func tabContent() -> some View {
        HStack(alignment: .center, spacing: self.spacing) {
            spacer()
            if let icon = self.viewModel.content.icon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.viewModel.tabStateAttributes.colors.icon.color)
                    .frame(width: self.iconHeight, height: self.iconHeight)
            }

            tabTitle()
                .foregroundColor(self.viewModel.tabStateAttributes.colors.label.color)
                .font(self.viewModel.tabStateAttributes.font.font)
                .fixedSize(horizontal: true, vertical: false)

            if let badge = self.viewModel.content.badge {
                badge
            }
            spacer()
        }
        .frame(height: self.itemHeight)
        .overlay(
            Rectangle()
                .frame(width: nil, height: self.lineHeight, alignment: .top)
                .foregroundColor(self.viewModel.tabStateAttributes.colors.line.color),
            alignment: .bottom)
        .accessibilityLabel(self.viewModel.content.title ?? TabAccessibilityIdentifier.tabItem)
    }

    @ViewBuilder
    private func spacer() -> some View {
        if !self.viewModel.apportionsSegmentWidthsByContent {
            Spacer()
                .frame(minWidth: self.paddingHorizontal)
        } else  {
            Spacer().frame(width: self.paddingHorizontal)
        }
    }

    @ViewBuilder
    private func tabTitle() -> some View {
        if let title = self.viewModel.content.title {
            Text(title)
        } else if let attributedTitle = self.viewModel.content.attributedTitle {
            Text(attributedTitle)
        } else {
            EmptyView()
        }
    }

    //MARK: - Public modifiers
    /// Indicates whether the control attempts to adjust segment widths based on their content widths.
    public func apportionsSegmentWidthsByContent(_ newValue: Bool) -> Self {
        self.viewModel.apportionsSegmentWidthsByContent = newValue
        return self
    }

    /// Add a badge to the view
    public func badge(_ badge: BadgeView) -> Self {
        self.viewModel.content.badge = badge
        return self
    }

    /// Set the tab as selected
    public func selected(_ selected: Bool) -> Self {
        self.viewModel.isSelected = selected
        return self
    }
}

//MARK: - Private Button Style
private struct TabItemButtonStyle: ButtonStyle {
    var viewModel: TabItemViewModel<TabItemContent>

    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed != self.viewModel.isPressed {
            DispatchQueue.main.async {
                self.viewModel.isPressed = configuration.isPressed
            }
        }
        return configuration.label
            .animation(.easeOut(duration: 0.1), value: self.viewModel.isPressed)
    }
}
