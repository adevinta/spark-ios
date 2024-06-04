//
//  ButtonContainerView.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Foundation
@_spi(SI_SPI) import SparkCommon
import SparkTheming

struct ButtonContainerView<ContainerView: View, ViewModel: ButtonMainViewModel & ButtonMainSUIViewModel>: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: ViewModel

    @ScaledMetric private var height: CGFloat
    @ScaledMetric private var borderWidth: CGFloat
    @ScaledMetric private var borderRadius: CGFloat
    private let padding: EdgeInsets?

    @State private var isPressed: Bool = false

    private let action: () -> Void

    // MARK: - Components

    private var contentView: () -> ContainerView

    // MARK: - Initialization

    init(
        viewModel: ViewModel,
        padding: EdgeInsets? = nil,
        action: @escaping () -> Void,
        contentView: @escaping () -> ContainerView
    ) {
        self.viewModel = viewModel

        self._height = .init(wrappedValue: viewModel.sizes?.height ?? .zero)
        self._borderWidth = .init(wrappedValue: viewModel.border?.width ?? .zero)
        self._borderRadius = .init(wrappedValue: viewModel.border?.radius ?? .zero)
        self.padding = padding

        self.action = action
        self.contentView = contentView
    }

    // MARK: - View

    var body: some View {
        Button(action: self.action) {
            self.contentView()
                .padding(self.padding)
                .frame(height: self.height)
                .frame(minWidth: self.height)
                .background(self.viewModel.currentColors?.backgroundColor.color ?? .clear)
                .contentShape(Rectangle())
                .border(
                    width: self.borderWidth,
                    radius: self.borderRadius,
                    colorToken: self.viewModel.currentColors?.borderColor ?? ColorTokenDefault.clear
                )
        }
        .buttonStyle(PressedButtonStyle(
            isPressed: self.$isPressed
        ))
        .compositingGroup()
        .disabled(self.viewModel.state?.isUserInteractionEnabled == false)
        .opacity(self.viewModel.state?.opacity ?? .zero)
        .accessibilityIdentifier(ButtonAccessibilityIdentifier.button)
        .accessibilityAddTraits(.isButton)
        .onChange(of: self.isPressed) { isPressed in
            self.viewModel.setIsPressed(isPressed)
        }
    }
}

// MARK: - Modifier

private struct ButtonOptionalPaddingModifier: ViewModifier {

    // MARK: - Properties

    var padding: EdgeInsets?

    // MARK: - Initialization

    func body(content: Content) -> some View {
        if let padding = self.padding {
            content.padding(padding)
        } else {
            content
        }
    }
}

private extension View {

    func padding(_ padding: EdgeInsets?) -> some View {
        self.modifier(ButtonOptionalPaddingModifier(
            padding: padding
        ))
    }
}
