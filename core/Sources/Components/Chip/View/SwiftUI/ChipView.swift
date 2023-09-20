//
//  ChipView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct ChipView: View {

    @ObservedObject private var viewModel: ChipViewModel<ChipContent>
    @ScaledMetric private var imageSize = ChipConstants.imageSize
    @ScaledMetric private var height = ChipConstants.height
    @ScaledMetric private var borderWidth = ChipConstants.borderWidth
    @ScaledMetric private var dashLength = ChipConstants.dashLength
    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var padding: CGFloat
    @ScaledMetric private var borderRadius: CGFloat

    private var action: (() -> Void)?

    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                icon: Image,
                action: (() -> Void)? = nil
    ) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  title: nil,
                  icon: icon,
                  action: action
        )
    }

    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                title: String,
                action: (() -> Void)? = nil
    ) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  title: title,
                  icon: nil,
                  action: action
        )
    }

    public init(theme: Theme,
         intent: ChipIntent,
         variant: ChipVariant,
         alignment: ChipAlignment,
         title: String?,
         icon: Image?,
         action: (() -> Void)? = nil
    ) {
        let viewModel = ChipViewModel<ChipContent>(
            theme: theme,
            variant: variant,
            intent: intent,
            alignment: alignment,
            content: ChipContent(title: title, icon: icon))

        self.init(viewModel: viewModel,
                  title: title,
                  icon: icon,
                  action: action
        )
    }

    internal init(viewModel: ChipViewModel<ChipContent>,
                  title: String?,
                  icon: Image?,
                  action: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.action = action

        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self._padding = ScaledMetric(wrappedValue: viewModel.padding)
        self._borderRadius = ScaledMetric(wrappedValue: viewModel.borderRadius)

    }

    public var body: some View {

        if let action = action  {
            Button(action: action) {
                self.content()
            }
            .disabled(!self.viewModel.isEnabled)
            .opacity(self.viewModel.colors.opacity)
            .buttonStyle(ChipButtonStyle(viewModel: self.viewModel))
        } else {
            self.content()
        }
    }

    @ViewBuilder
    private func content() -> some View {
        HStack(spacing: self.spacing) {
            if self.viewModel.alignment == .leadingIcon {
                icon()
                title()
            } else {
                title()
                icon()
            }
            if let component = self.viewModel.content.component {
                component
                    .frame(height: self.imageSize)
            }
        }
        .padding(self.padding)
        .background(self.viewModel.colors.background.color)
        .if(self.viewModel.isBorderDashed,
            then: { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: self.borderRadius)
                    .strokeBorder(
                        self.viewModel.colors.foreground.color,
                        style: StrokeStyle(lineWidth: self.borderWidth, dash: [self.dashLength]))
                )
            },
            else: { view in
                view.border(width: self.borderWidth,
                        radius: self.borderRadius,
                        colorToken: self.viewModel.colors.border)
            }
        )
        .frame(height: self.height)
    }

    @ViewBuilder
    private func icon() -> some View {
        if let icon = self.viewModel.content.icon {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(self.viewModel.colors.foreground.color)
                .frame(width: self.imageSize, height: self.imageSize)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func title() -> some View {
        if let title = self.viewModel.content.title {
            Text(title)
                .font(self.viewModel.font.font)
                .foregroundColor(self.viewModel.colors.foreground.color)
        } else {
            EmptyView()
        }
    }

    public func icon(_ icon: Image?) -> Self {
        self.viewModel.content.icon = icon
        return self
    }

    public func title(_ title: String?) -> Self {
        self.viewModel.content.title = title
        return self
    }

    public func component(_ component: AnyView?) -> Self {
        self.viewModel.content.component = component
        return self
    }
}

//MARK: - Private Button Style
private struct ChipButtonStyle: ButtonStyle {
    var viewModel: ChipViewModel<ChipContent>

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
