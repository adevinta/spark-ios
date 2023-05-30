//
//  RadioButtonUIGroupView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 24.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

private enum Constants {
    static let touchPadding: CGFloat = 16
}

/// RadioButtonGroupView embodies a radio button group and handles 
public final class RadioButtonUIGroupView<ID: Equatable & Hashable & CustomStringConvertible>: UIView {

    // MARK: - Private Properties
    private var selectedID: Binding<ID>
    public var theme: Theme {
        didSet {
            for radioButtonView in radioButtonViews {
                radioButtonView.theme = theme
            }

            self.setNeedsDisplay()
        }
    }
    private let items: [RadioButtonItem<ID>]
    private let title: String?
    private var itemConstraints = [NSLayoutConstraint]()
    public var radioButtonLabelPosition: RadioButtonLabelPosition {
        didSet {
            guard radioButtonLabelPosition != oldValue else { return }

            for radioButtonView in radioButtonViews {
                radioButtonView.labelPosition = radioButtonLabelPosition
            }

            self.setNeedsDisplay()
        }
    }

    @ScaledUIMetric var spacing: CGFloat

    private var stackView = UIStackView()

    private lazy var backingSelectedID: Binding<ID> = Binding(
        get: {
            return self.selectedID.wrappedValue
        },
        set: { newValue in
            self.selectedID.wrappedValue = newValue
            self.updateRadioButtonStates()
        }
    )

    private var radioButtonViews: [RadioButtonUIView<ID>] = []

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: Initializers
    public init(theme: Theme,
                title: String? = nil,
                selectedID: Binding<ID>,
                items: [RadioButtonItem<ID>],
                radioButtonLabelPosition: RadioButtonLabelPosition = .right
    ) {
        self.theme = theme
        self.items = items
        self.selectedID = selectedID
        self.title = title
        self.radioButtonLabelPosition = radioButtonLabelPosition
        self._spacing = ScaledUIMetric(wrappedValue: (theme.layout.spacing.xLarge - Constants.touchPadding))
        super.init(frame: .zero)

        arrangeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._spacing.update(traitCollection: self.traitCollection)

        for constraint in self.itemConstraints {
            constraint.constant = spacing
        }
    }

    // MARK: Private Methods

    private func arrangeView() {
        self.radioButtonViews = items.map {
            RadioButtonUIView(theme: theme,
                              id: $0.id,
                              label: $0.label,
                              selectedID: self.backingSelectedID,
                              state: $0.state,
                              labelPosition: self.radioButtonLabelPosition
            )
        }

        var previousLayoutTopAnchor = self.safeAreaLayoutGuide.topAnchor
        var constraints = [NSLayoutConstraint]()

        if let title = self.title {
            self.titleLabel.text = title
            self.titleLabel.font = self.theme.typography.subhead.uiFont
            self.titleLabel.textColor = self.theme.colors.base.onSurface.uiColor

            self.addSubview(self.titleLabel)

            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            previousLayoutTopAnchor = self.titleLabel.bottomAnchor
        }

        for radioButtonView in radioButtonViews {
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(radioButtonView)

            constraints.append(radioButtonView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(radioButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

            let itemConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: self.spacing)
            self.itemConstraints.append(itemConstraint)
            constraints.append(itemConstraint)

            previousLayoutTopAnchor = radioButtonView.bottomAnchor
        }

        constraints.append(previousLayoutTopAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

        NSLayoutConstraint.activate(constraints)

        self.addSubview(self.stackView)
    }

    private func updateRadioButtonStates() {
        for radioButtonView in self.radioButtonViews {
            radioButtonView.toggleNeedsRedisplay()
        }
    }
}
