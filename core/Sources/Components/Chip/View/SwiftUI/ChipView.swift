//
//  ChipView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// ChipView.
/// A chip view may contain an icon, a title and a further view of type AnyView.
/// The icon and title are the first two items of the chip and their position depends on the given alignment.
/// The extra component is always the last component in the view.
public struct ChipView: View {

    private enum Constants {
        static let verticalPadding: CGFloat = 6.25
    }
    @ObservedObject private var viewModel: ChipViewModel<ChipContent>
    @ScaledMetric private var imageSize = ChipConstants.imageSize
    @ScaledMetric private var height = ChipConstants.height
    @ScaledMetric private var borderWidth = ChipConstants.borderWidth
    @ScaledMetric private var dashLength = ChipConstants.dashLength
    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var padding: CGFloat
    @ScaledMetric private var paddingVertical = Constants.verticalPadding
    @ScaledMetric private var borderRadius: CGFloat

    private var action: (() -> Void)?

    // MARK: - Initializers
    /// Initializer of a chip containing only an icon.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - icon: An icon
    /// - action: An optional action. If the chip has an action, it will be treated like a button
    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                icon: Image,
                action: (() -> Void)? = nil) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  icon: icon,
                  title: nil,
                  action: action
        )
    }

    /// Initializer of a chip containing only a title.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - icon: An icon
    /// - action: An optional action. If the chip has an action, it will be treated like a button
    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                title: String,
                action: (() -> Void)? = nil) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  icon: nil,
                  title: title,
                  action: action
        )
    }

    /// Initializer of a chip with an optional title and an optional icon.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - icon: An optional icon
    /// - title: An optional title
    /// - action: An optional action. If the chip has an action, it will be treated like a button
    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                icon: Image?,
                title: String?,
                action: (() -> Void)? = nil) {
        let viewModel = ChipViewModel<ChipContent>(
            theme: theme,
            variant: variant,
            intent: intent,
            alignment: alignment,
            content: ChipContent(title: title, icon: icon))

        self.init(viewModel: viewModel,
                  action: action
        )
    }

    // MARK: Internal initalizer
    internal init(viewModel: ChipViewModel<ChipContent>,
                  action: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.action = action

        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self._padding = ScaledMetric(wrappedValue: viewModel.padding)
        self._borderRadius = ScaledMetric(wrappedValue: viewModel.borderRadius)

    }

    // MARK: - View
    public var body: some View {
        Button(action: self.action ?? {}) {
            self.content()
        }
        .frame(height: self.height)
        .background(self.viewModel.colors.background.color)
        .if(self.viewModel.isBordered) { view in
            view.chipBorder(width: self.borderWidth,
                            radius: self.borderRadius,
                            dashLength: self.borderDashLength(),
                            colorToken: self.viewModel.colors.border)
        }
        .opacity(self.viewModel.colors.opacity)
        .cornerRadius(self.borderRadius)
        .disabled(!self.viewModel.isEnabled)
        .buttonStyle(ChipButtonStyle(viewModel: self.viewModel, hasAction: self.action != nil))
        .accessibilityIdentifier(ChipAccessibilityIdentifier.identifier)
    }

    private func borderDashLength() -> CGFloat? {
        return self.viewModel.isBorderDashed ? self.dashLength : nil
    }

    @ViewBuilder
    private func content() -> some View {
        HStack(spacing: self.spacing) {
            if self.viewModel.alignment == .leadingIcon {
                self.icon()
                self.title()
            } else {
                self.title()
                self.icon()
            }
            if let component = self.viewModel.content.component {
                component
                    .frame(height: self.imageSize)
            }
        }
        .padding(EdgeInsets(vertical: self.verticalPadding(), horizontal: self.padding))
    }

    private func verticalPadding() -> CGFloat {
        if self.viewModel.content.title == nil {
            return self.padding
        } else {
            return self.paddingVertical
        }
    }

    @ViewBuilder
    private func icon() -> some View {
        if let icon = self.viewModel.content.icon {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(self.viewModel.colors.foreground.color)
                .accessibilityIdentifier(ChipAccessibilityIdentifier.icon)
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
                .accessibilityIdentifier(ChipAccessibilityIdentifier.text)
        } else {
            EmptyView()
        }
    }

    // MARK: - Modifiers
    /// Set an icon
    public func icon(_ icon: Image?) -> Self {
        self.viewModel.content.icon = icon
        return self
    }

    /// Set a title
    public func title(_ title: String?) -> Self {
        self.viewModel.content.title = title
        return self
    }

    /// Set an extra component
    public func component(_ component: AnyView?) -> Self {
        self.viewModel.content.component = component
        return self
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

// MARK: - Private Button Style
private struct ChipButtonStyle: ButtonStyle {
    var viewModel: ChipViewModel<ChipContent>
    var hasAction: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        if self.hasAction, configuration.isPressed != self.viewModel.isPressed {
            DispatchQueue.main.async {
                self.viewModel.isPressed = configuration.isPressed
            }
        }
        return configuration.label
            .animation(.easeOut(duration: 0.2), value: self.viewModel.isPressed)
    }
}

// MARK: - View Border Extension
private extension View {
    func chipBorder(width: CGFloat,
                      radius: CGFloat,
                      dashLength: CGFloat?,
                      colorToken: any ColorToken) -> some View {
        self.modifier(
            ChipBorderViewModifier(
                width: width,
                radius: radius,
                dashLength: dashLength,
                colorToken: colorToken))
    }
}

private struct ChipBorderViewModifier: ViewModifier {
    // MARK: - Properties

    private let width: CGFloat
    private let radius: CGFloat
    private let dashLength: CGFloat?
    private let colorToken: any ColorToken

    // MARK: - Initialization

    init(width: CGFloat,
         radius: CGFloat,
         dashLength: CGFloat?,
         colorToken: any ColorToken) {
        self.width = width
        self.radius = radius
        self.dashLength = dashLength
        self.colorToken = colorToken
    }

    // MARK: - View
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius)
            .overlay(self.rectangle())
    }

    @ViewBuilder
    private func rectangle() -> some View {
        if let dashLength = dashLength {
            RoundedRectangle(cornerRadius: self.radius)
                .stroke(
                    self.colorToken.color,
                    style: StrokeStyle(lineWidth: self.width, dash: [dashLength]))
        } else  {
            RoundedRectangle(cornerRadius: self.radius)
                .stroke(
                    self.colorToken.color,
                    lineWidth: self.width)
        }
    }
}
