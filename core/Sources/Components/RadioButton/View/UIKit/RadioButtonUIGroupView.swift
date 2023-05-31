//
//  RadioButtonUIGroupView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 24.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

/// RadioButtonGroupView embodies a radio button group and handles 
public final class RadioButtonUIGroupView<ID: Equatable & Hashable & CustomStringConvertible>: UIView {

    // MARK: - Private Properties
    private var selectedID: Binding<ID>
    public var theme: Theme {
        didSet {
            for radioButtonView in radioButtonViews {
                radioButtonView.theme = theme
            }
            self._spacing = ScaledUIMetric(wrappedValue: theme.layout.spacing.xLarge)
        }
    }
    private let items: [RadioButtonItem<ID>]
    private let title: String?
    private var itemSpacingConstraints = [NSLayoutConstraint]()
    private var allConstraints = [NSLayoutConstraint]()

    public var radioButtonLabelPosition: RadioButtonLabelPosition {
        didSet {
            guard radioButtonLabelPosition != oldValue else { return }

            for radioButtonView in radioButtonViews {
                radioButtonView.labelPosition = radioButtonLabelPosition
            }

        }
    }

    public var groupLayout: RadioButtonGroupLayout {
        didSet {
            guard groupLayout != oldValue else { return }
            NSLayoutConstraint.deactivate(self.allConstraints)
            self.setupConstraints()
        }
    }

    @ScaledUIMetric var spacing: CGFloat

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
                radioButtonLabelPosition: RadioButtonLabelPosition = .right,
                groupLayout: RadioButtonGroupLayout = .vertical
    ) {
        self.theme = theme
        self.items = items
        self.selectedID = selectedID
        self.title = title
        self.radioButtonLabelPosition = radioButtonLabelPosition
        self.groupLayout = groupLayout
        self._spacing = ScaledUIMetric(wrappedValue: theme.layout.spacing.xLarge)
        super.init(frame: .zero)

        arrangeView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._spacing.update(traitCollection: self.traitCollection)

        for constraint in self.itemSpacingConstraints {
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

        if let title = self.title {
            self.titleLabel.text = title
            self.titleLabel.font = self.theme.typography.subhead.uiFont
            self.titleLabel.textColor = self.theme.colors.base.onSurface.uiColor

            self.addSubview(self.titleLabel)
        }

        for radioButtonView in radioButtonViews {
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(radioButtonView)
        }
    }

    private func setupConstraints() {
        if self.groupLayout == .vertical {
            setupVerticalConstraints()
        } else {
            setupHorizontalConstraints()
        }
    }

    func setupVerticalConstraints() {
        var previousLayoutTopAnchor = self.safeAreaLayoutGuide.topAnchor
        var constraints = [NSLayoutConstraint]()

        if self.title != nil {
            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            previousLayoutTopAnchor = self.titleLabel.bottomAnchor
        }

        for radioButtonView in radioButtonViews {
            constraints.append(radioButtonView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(radioButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

            let itemConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: self.spacing)
            self.itemSpacingConstraints.append(itemConstraint)
            constraints.append(itemConstraint)

            previousLayoutTopAnchor = radioButtonView.bottomAnchor
        }

        constraints.append(previousLayoutTopAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

        self.allConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }

    func setupHorizontalConstraints() {
        var previousLayoutTopAnchor = self.safeAreaLayoutGuide.topAnchor
        var previousLayoutLeadingAnchor = self.safeAreaLayoutGuide.leadingAnchor
        var constraints = [NSLayoutConstraint]()

        if self.title != nil {
            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            previousLayoutTopAnchor = self.titleLabel.bottomAnchor
        }

        for (index, radioButtonView) in radioButtonViews.enumerated() {
            constraints.append(radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            constraints.append(radioButtonView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

            if index == 0 {
                constraints.append(radioButtonView.leadingAnchor.constraint(equalTo: previousLayoutLeadingAnchor))
            } else {
                let itemConstraint = radioButtonView.leadingAnchor.constraint(equalTo: previousLayoutLeadingAnchor, constant: self.spacing)
                self.itemSpacingConstraints.append(itemConstraint)
                constraints.append(itemConstraint)
            }
            previousLayoutLeadingAnchor = radioButtonView.trailingAnchor
        }
        constraints.append(previousLayoutLeadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

        self.allConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }

    private func updateRadioButtonStates() {
        for radioButtonView in self.radioButtonViews {
            radioButtonView.toggleNeedsRedisplay()
        }
    }
}
