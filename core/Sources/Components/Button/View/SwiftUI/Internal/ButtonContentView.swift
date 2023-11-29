//
//  ButtonContentView.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Foundation

struct ButtonContentView<ContentView: View, ViewModel: ButtonMainViewModel>: View {

    // MARK: - Properties

    private let manager: ButtonMainManager<ViewModel>

    private var viewModel: ButtonMainViewModel {
        return self.manager.viewModel
    }

    @ScaledMetric private var height: CGFloat
    private let padding: EdgeInsets?

    private let action: () -> Void

    // MARK: - Components

    private var contentView: () -> ContentView

    // MARK: - Initialization

    init(
        manager: ButtonMainManager<ViewModel>,
        padding: EdgeInsets? = nil,
        action: @escaping () -> Void,
        contentView: @escaping () -> ContentView
    ) {
        self.manager = manager
        self._height = .init(wrappedValue: manager.viewModel.sizes?.height ?? .zero)
        self.padding = padding
        self.action = action
        self.contentView = contentView
    }

    // MARK: - View

    var body: some View {
        Button(action: self.action) {
            self.contentView()
        }
        .buttonStyle(PressedButtonStyle(
            manager: self.manager
        ))
        .padding(self.padding)
        .frame(height: self.height)
        .frame(minWidth: self.height)
        .background(self.viewModel.currentColors?.backgroundColor.color ?? .clear)
        .border(
            width: self.viewModel.border?.width ?? .zero,
            radius: self.viewModel.border?.radius ?? .zero,
            colorToken: self.viewModel.currentColors?.borderColor ?? ColorTokenDefault.clear
        )
        .compositingGroup()
        .disabled(!(self.viewModel.state?.isUserInteractionEnabled ?? true))
        .opacity(self.viewModel.state?.opacity ?? .zero)
        .accessibilityIdentifier(ButtonAccessibilityIdentifier.button)
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

// MARK: - Style

private struct PressedButtonStyle<ViewModel: ButtonMainViewModel>: ButtonStyle {

    // MARK: - Properties

    let manager: ButtonMainManager<ViewModel>

    // MARK: - View

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .onChange(of: configuration.isPressed) { value in
            self.manager.setIsPressed(value)
        }
    }
}
