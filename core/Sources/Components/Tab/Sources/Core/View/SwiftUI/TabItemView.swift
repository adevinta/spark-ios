//
//  TabItemView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// A single tab item used on the tab view.
struct TabItemView: View {

    // MARK: - Private Variables
    @ObservedObject private var viewModel: TabItemViewModel<TabItemContent>

    private let tapAction: () -> Void

    // MARK: - Scaled Metrics
    @ScaledMetric private var factor: CGFloat = 1

    private var lineHeight: CGFloat {
        return self.viewModel.tabStateAttributes.heights.separatorLineHeight * self.factor
    }

    private var itemHeight: CGFloat {
        return self.viewModel.tabStateAttributes.heights.itemHeight * self.factor
    }
    private var iconHeight: CGFloat {
        return self.viewModel.tabStateAttributes.heights.iconHeight * self.factor
    }
    private var paddingHorizontal: CGFloat {
        return self.viewModel.tabStateAttributes.spacings.horizontalEdge * self.factor
    }
    private var spacing: CGFloat {
        return self.viewModel.tabStateAttributes.spacings.content * self.factor
    }

    // MARK: Initialization
    /// Initializer
    /// - Parameters:
    /// - viewModel: The view model of the tab item.
    /// - tapAction: the action triggered by tapping on the tab.
    init(
        viewModel: TabItemViewModel<TabItemContent>,
        tapAction: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.tapAction = tapAction
   }

    // MARK: - View
    var body: some View {
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
        .buttonStyle(PressedButtonStyle(isPressed: self.$viewModel.isPressed, animationDuration: 0.1))
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

    // MARK: - Public modifiers
    /// Indicates whether the control attempts to adjust segment widths based on their content widths.
    func apportionsSegmentWidthsByContent(_ newValue: Bool) -> Self {
        self.viewModel.apportionsSegmentWidthsByContent = newValue
        return self
    }

    /// Add a badge to the view
    func badge(_ badge: BadgeView) -> Self {
        self.viewModel.content.badge = badge
        return self
    }

    /// Set the tab as selected
    func selected(_ selected: Bool) -> Self {
        self.viewModel.updateState(isSelected: selected)
        return self
    }
}
