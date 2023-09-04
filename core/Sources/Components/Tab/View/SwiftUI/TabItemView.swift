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
    private var image: Image?
    private var title: String?
    private var attributedTitle: AttributedString?
    private var badge: Badge?
    @State private var fullWidth: Bool

    public init(
        theme: Theme,
        intent: TabIntent = .basic,
        size: TabSize = .md,
        image: Image? = nil,
        title: String? = nil,
        attributedTitle: String? = nil,
        badge: Badge? = nil,
        fullWidth: Bool = true
    ) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent, tabSize: size)
        self.init(viewModel: viewModel,
                  image: image,
                  title: title,
                  attributedTitle: attributedTitle,
                  badge: badge,
                  fullWidth: fullWidth)
    }

    init(
        viewModel: TabItemViewModel,
        image: Image?,
        title: String?,
        attributedTitle: String?,
        badge: Badge?,
        fullWidth: Bool
    ) {
        self.viewModel = viewModel
        self.badge = badge
        self.image = image
        self.title = title
        self._fullWidth = State(wrappedValue: fullWidth)

    }
    public var body: some View {
        Button(
            action: {
                print("BUTTON PRESSED")
            },
            label: {
                self.tabContent()
            })
        .disabled(!self.viewModel.isEnabled)
        .opacity(self.viewModel.tabStateAttributes.colors.opacity)
        .buttonStyle(TabItemButtonStyle(viewModel: self.viewModel))
    }

    @ViewBuilder
    private func tabContent() -> some View {
        HStack(alignment: .center, spacing: 10) {
            spacer()
            if let image {
                image
                    .foregroundColor(self.viewModel.tabStateAttributes.colors.icon.color)
            }

            tabTitle()
                .foregroundColor(self.viewModel.tabStateAttributes.colors.label.color)
                .font(self.viewModel.tabStateAttributes.font.font)

            if let badge {
                badge
            }
            spacer()
        }
        .padding(10)
        .overlay(
            Rectangle()
                .frame(width: nil, height: self.viewModel.tabStateAttributes.heights.separatorLineHeight, alignment: .top)
                .foregroundColor(self.viewModel.tabStateAttributes.colors.line.color),
            alignment: .bottom)
    }

    @ViewBuilder
    private func spacer() -> some View {
        if self.fullWidth {
            Spacer().frame(minWidth: 10)
        } else  {
            Spacer().frame(width: 10)
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

    public func selected(_ selected: Bool) -> Self {
        self.viewModel.isSelected = selected
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
