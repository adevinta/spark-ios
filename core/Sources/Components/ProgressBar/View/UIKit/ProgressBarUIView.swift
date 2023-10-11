//
//  ProgressBarUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

/// The UIKit version for the progress bar.
public final class ProgressBarUIView: ProgressBarMainUIView {
    
    // MARK: - Public Properties

    /// The spark theme of the progress bar.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// The intent of the progress bar.
    public var intent: ProgressBarIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.set(intent: newValue)
        }
    }

    /// The shape of the progress bar.
    public var shape: ProgressBarShape {
        get {
            return self.viewModel.shape
        }
        set {
            self.viewModel.set(shape: newValue)
        }
    }

    /// The indicator value of the progress bar.
    /// note: Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    public var value: CGFloat = 0 {
        didSet {
            self.updateWidthConstraints(
                &self.indicatorWidthConstraint,
                multiplier: self.value,
                view: self.indicatorView
            )
        }
    }

    // MARK: - Private Properties

    private let viewModel: ProgressBarViewModel

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new progress bar view
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar.
    ///   - intent: The intent of the progress bar.
    ///   - shape: The shape of the progress bar.
    public init(
        theme: Theme,
        intent: ProgressBarIntent,
        shape: ProgressBarShape
    ) {
        self.viewModel = .init(
            for: .uiKit,
            theme: theme,
            intent: intent,
            shape: shape
        )

        super.init()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    override func setupView() {
        super.setupView()

        // Setup subscriptions
        self.setupSubscriptions()

        // Load view model
        self.viewModel.load()
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Colors
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            self?.updateColors(colors)
        }

        // Corner Radius
        self.viewModel.$cornerRadius.subscribe(in: &self.subscriptions) { [weak self] cornerRadius in
            guard let cornerRadius else { return }
            self?.cornerRadius = cornerRadius
        }
    }

    // MARK: - Update Constraints

    override func updateWidthConstraints(
        _ constraint: inout NSLayoutConstraint?,
        multiplier: CGFloat,
        view: UIView
    ) {
        // Update constraints only if value is valid
        guard self.viewModel.isValidIndicatorValue(multiplier) else {
            return
        }

        super.updateWidthConstraints(&constraint, multiplier: multiplier, view: view)
    }
}
