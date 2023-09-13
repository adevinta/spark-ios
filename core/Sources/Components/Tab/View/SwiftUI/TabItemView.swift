//
//  TabItemView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TabItemView: View {

    @ObservedObject private var viewModel: TabItemViewModel<TabItemContent>

    private let tapAction: () -> Void

    @ScaledMetric private var lineHeight: CGFloat
    @ScaledMetric private var itemHeight: CGFloat
    @ScaledMetric private var iconHeight: CGFloat
    @ScaledMetric private var paddingVertical: CGFloat
    @ScaledMetric private var paddingHorizontal: CGFloat
    @ScaledMetric private var spacing: CGFloat

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
        self._paddingVertical = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.spacings.verticalEdge)
        self._paddingHorizontal = ScaledMetric(wrappedValue: viewModel.tabStateAttributes.spacings.horizontalEdge)
    }

    public var body: some View {
        Button(
            action: {
                self.tapAction()
            },
            label: {
                self.tabContent()
                    .background(self.viewModel.tabStateAttributes.colors.background.color)
            })
        .disabled(!self.viewModel.isEnabled)
        .opacity(self.viewModel.tabStateAttributes.colors.opacity)
        .buttonStyle(TabItemButtonStyle(viewModel: self.viewModel))
    }

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
        .padding(EdgeInsets(vertical: self.paddingVertical, horizontal: 0))
        .overlay(
            Rectangle()
                .frame(width: nil, height: self.lineHeight, alignment: .top)
                .foregroundColor(self.viewModel.tabStateAttributes.colors.line.color),
            alignment: .bottom)
    }

    @ViewBuilder
    private func spacer() -> some View {
        if !self.viewModel.apportionsSegmentWidthsByContent {
            Spacer().frame(minWidth: self.paddingHorizontal)
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
    /// Set the tab to disabled
    public func disabled(_ disabled: Bool) -> Self {
        self.viewModel.isEnabled = !disabled
        return self
    }

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
            .animation(.easeOut(duration: 0.2), value: self.viewModel.isPressed)
    }
}
