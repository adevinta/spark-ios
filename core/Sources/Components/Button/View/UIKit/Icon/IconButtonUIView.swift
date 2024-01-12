//
//  IconIconButtonUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// The UIKit version for the icon button.
public final class IconButtonUIView: ButtonMainUIView {

    // MARK: - Initialization

    /// Initialize a new button view.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    public init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape
    ) {
        let viewModel = IconButtonViewModel(
            for: .uiKit,
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape
        )

        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    internal override func setupView() {
        // Accessibility Identifier
        self.accessibilityIdentifier = ButtonAccessibilityIdentifier.iconButton

        // Add subviews
        self.addSubview(self.imageView)

        super.setupView()
    }

    // MARK: - Constraints

    internal override func setupImageViewConstraints() {
        super.setupImageViewConstraints()

        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
