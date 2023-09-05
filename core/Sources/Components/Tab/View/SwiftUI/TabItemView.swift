//
//  TabItemView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TabItemView<Badge: View>: View {

    @ObservedObject private var viewModel: TabItemViewModel
    private let image: Image?
    private let title: String?
    private let attributedTitle: AttributedString?
    private let badge: Badge?
    private let apportionsSegmentWidthsByContent: Bool
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
        image: Image? = nil,
        title: String? = nil,
        attributedTitle: AttributedString? = nil,
        badge: Badge? = nil,
        apportionsSegmentWidthsByContent: Bool = false,
        isSelected: Bool = true,
        tapAction: @escaping () -> Void
    ) {
        let viewModel = TabItemViewModel(theme: theme,
                                         intent: intent,
                                         tabSize: size)
        viewModel.hasTitle = title != nil || attributedTitle != nil
        viewModel.isSelected = isSelected
        self.init(viewModel: viewModel,
                  image: image,
                  title: title,
                  attributedTitle: attributedTitle,
                  badge: badge,
                  apportionsSegmentWidthsByContent: apportionsSegmentWidthsByContent,
                  tapAction: tapAction
        )
    }

    init(
        viewModel: TabItemViewModel,
        image: Image?,
        title: String?,
        attributedTitle: AttributedString?,
        badge: Badge?,
        apportionsSegmentWidthsByContent: Bool,
        tapAction: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.badge = badge
        self.image = image
        self.title = title
        self.attributedTitle = attributedTitle
        self.tapAction = tapAction
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent

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
            })
        .background(self.viewModel.tabStateAttributes.colors.background.color)
        .disabled(!self.viewModel.isEnabled)
        .opacity(self.viewModel.tabStateAttributes.colors.opacity)
        .buttonStyle(TabItemButtonStyle(viewModel: self.viewModel))
    }

    @ViewBuilder
    private func tabContent() -> some View {
        HStack(alignment: .center, spacing: self.spacing) {
            spacer()
            if let image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.viewModel.tabStateAttributes.colors.icon.color)
                    .frame(width: self.iconHeight, height: self.iconHeight)
            }

            tabTitle()
                .foregroundColor(self.viewModel.tabStateAttributes.colors.label.color)
                .font(self.viewModel.tabStateAttributes.font.font)
                .fixedSize(horizontal: true, vertical: false)

            if let badge {
                badge
            }
            spacer()
        }
        .padding(EdgeInsets(vertical: self.paddingVertical, horizontal: 0))
        .overlay(
            Rectangle()
                .frame(width: nil, height: self.lineHeight, alignment: .top)
                .foregroundColor(self.viewModel.tabStateAttributes.colors.line.color),
            alignment: .bottom)
        .frame(idealHeight: self.itemHeight)
    }

    @ViewBuilder
    private func spacer() -> some View {
        if !self.apportionsSegmentWidthsByContent {
            Spacer().frame(minWidth: self.paddingHorizontal)
        } else  {
            Spacer().frame(width: self.paddingHorizontal)
        }
    }

    @ViewBuilder
    private func tabTitle() -> some View {
        if let title {
            Text(title)
        } else if let attributedTitle {
            Text(attributedTitle)
        } else {
            EmptyView()
        }
    }

    public func disabled(_ disabled: Bool) -> Self {
        self.viewModel.isEnabled = !disabled
        return self
    }
}

private struct TabItemButtonStyle: ButtonStyle {
    var viewModel: TabItemViewModel

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
