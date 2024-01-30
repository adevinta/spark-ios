//
//  ButtonView.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Foundation

public struct ButtonView: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ButtonSUIViewModel

    @ScaledMetric private var verticalSpacing: CGFloat
    @ScaledMetric private var horizontalSpacing: CGFloat
    @ScaledMetric private var horizontalPadding: CGFloat

    private var action: () -> Void

    // MARK: - Initialization

    /// Initialize a new button view.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - action: The action of the button.   
    public init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        action: @escaping () -> Void
    ) {
        let viewModel = ButtonSUIViewModel(
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment
        )
        self.viewModel = viewModel

        // **
        // Scaled Metric
        self._verticalSpacing = .init(wrappedValue: viewModel.spacings?.verticalSpacing ?? .zero)
        self._horizontalSpacing = .init(wrappedValue: viewModel.spacings?.horizontalSpacing ?? .zero)
        self._horizontalPadding = .init(wrappedValue: viewModel.spacings?.horizontalPadding ?? .zero)
        // **

        self.action = action
    }

    // MARK: - View

    public var body: some View {
        ButtonContainerView(
            viewModel: self.viewModel,
            padding: .init(
                vertical: self.verticalSpacing,
                horizontal: self.horizontalSpacing
            ),
            action: self.action
        ) {
            self.content()
        }
    }

    // MARK: - View Builder

    @ViewBuilder
    private func content() -> some View {
        HStack(
            alignment: .center,
            spacing: self.horizontalPadding
        ) {
            if self.viewModel.isImageTrailing {
                self.title()
                self.image()
            } else {
                self.image()
                self.title()
            }
        }
        .animation(nil, value: UUID())
    }

    @ViewBuilder
    private func image() -> some View {
        ButtonImageView(viewModel: self.viewModel)
    }

    @ViewBuilder
    private func title() -> some View {
        if let text = self.viewModel.controlStateText?.text {
            Text(text)
                .foregroundStyle(self.viewModel.currentColors?.titleColor?.color ?? ColorTokenDefault.clear.color)
                .font(self.viewModel.titleFontToken?.font)
                .accessibilityIdentifier(ButtonAccessibilityIdentifier.text)
        } else if let attributedText = self.viewModel.controlStateText?.attributedText {
            Text(attributedText)
                .accessibilityIdentifier(ButtonAccessibilityIdentifier.text)
        }
    }

    // MARK: - Modifier

    /// Set the image of the button for a state.
    /// - parameter image: new image of the button
    /// - parameter state: state of the image
    /// - Returns: Current Button View.
    public func image(_ image: Image?, for state: ControlState) -> Self {
        self.viewModel.setImage(image, for: state)
        return self
    }

    /// Set the title of the button for a state.
    /// - parameter title: new title of the button
    /// - parameter state: state of the title
    /// - Returns: Current Button View.
    public func title(_ title: String?, for state: ControlState) -> Self {
        self.viewModel.setTitle(
            title,
            for: state
        )

        return self
    }

    /// Set the attributedTitle of the button for a state.
    /// - parameter attributedTitle: new attributedTitle of the button
    /// - parameter state: state of the attributedTitle
    /// - Returns: Current Button View.
    public func attributedTitle(_ attributedTitle: AttributedString?, for state: ControlState) -> Self {
        self.viewModel.setAttributedTitle(
            attributedTitle,
            for: state
        )

        return self
    }

    /// Set the button to disabled.
    /// - Parameters:
    ///   - text: The button is disabled or not.
    /// - Returns: Current Button View.
    public func disabled(_ isDisabled: Bool) -> Self {
        self.viewModel.setIsDisabled(isDisabled)

        return self
    }

    /// Set the button to selected.
    /// - Parameters:
    ///   - text: The switch is selected or not.
    /// - Returns: Current Button View.
    public func selected(_ isSelected: Bool) -> Self {
        self.viewModel.setIsSelected(isSelected)

        return self
    }
}
