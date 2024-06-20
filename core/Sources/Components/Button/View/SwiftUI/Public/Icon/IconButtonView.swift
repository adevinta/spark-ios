//
//  IconButtonView.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Foundation

public struct IconButtonView: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel: IconButtonSUIViewModel

    private var action: () -> Void

    // MARK: - Initialization

    /// Initialize a new button view.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - action: The action of the button.
    public init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        action: @escaping () -> Void
    ) {
        let viewModel = IconButtonSUIViewModel(
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape
        )
        self.viewModel = viewModel

        self.action = action
    }

    // MARK: - View

    public var body: some View {
        ButtonContainerView(
            viewModel: self.viewModel,
            action: self.action
        ) {
            ButtonImageView(viewModel: self.viewModel)
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

    /// Set the button to disabled.
    /// - Parameters:
    ///   - text: The button is disabled or not.
    /// - Returns: Current Button View.
    public func disabled(_ isDisabled: Bool) -> Self {
        self.viewModel.setIsDisabled(isDisabled)

        return self
    }

    /// Set the switch to selected.
    /// - Parameters:
    ///   - text: The switch is selected or not.
    /// - Returns: Current Button View.
    public func selected(_ isSelected: Bool) -> Self {
        self.viewModel.setIsSelected(isSelected)

        return self
    }
}
