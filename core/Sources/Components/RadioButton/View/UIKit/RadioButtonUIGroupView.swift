//
//  RadioButtonUIGroupView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 24.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit
import SwiftUI

/// RadioButtonGroupView embodies a radio button group and handles
public final class RadioButtonUIGroupView<ID: Equatable & Hashable & CustomStringConvertible>: UIView {

    // MARK: - Private Properties
    private let items: [RadioButtonUIItem<ID>]
    private let title: String?
    private var itemSpacingConstraints = [NSLayoutConstraint]()
    private var allConstraints = [NSLayoutConstraint]()
    private let currentValue: CurrentValueSubject<ID, Never>

    @ScaledUIMetric private var spacing: CGFloat

    private lazy var backingSelectedID: Binding<ID> = Binding(
        get: {
            return self.selectedID
        },
        set: { newValue in
            self.selectedID = newValue
            self.currentValue.send(newValue)
            self.delegate?.radioButtonGroup(self, didChangeSelection: newValue)
        }
    )

    private var radioButtonViews: [RadioButtonUIView<ID>] = []

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Public Properties

    /// The current selected ID. 
    public var selectedID: ID {
        didSet {
            self.updateRadioButtonStates()
        }
    }

    /// The current theme
    public var theme: Theme {
        didSet {
            for radioButtonView in radioButtonViews {
                radioButtonView.theme = theme
            }
            self._spacing = ScaledUIMetric(wrappedValue: theme.layout.spacing.xLarge)
        }
    }

    /// The label position according to the toggle, either `left` or `right`. The default value is `.left`
    public var radioButtonLabelPosition: RadioButtonLabelPosition {
        didSet {
            guard radioButtonLabelPosition != oldValue else { return }

            for radioButtonView in radioButtonViews {
                radioButtonView.labelPosition = radioButtonLabelPosition
            }

        }
    }

    /// The group layout of the radio buttons, either `horizontal` or `vertical`. The default is `vertical`.
    public var groupLayout: RadioButtonGroupLayout {
        didSet {
            guard groupLayout != oldValue else { return }
            NSLayoutConstraint.deactivate(self.allConstraints)
            self.setupConstraints()
        }
    }

    /// A delegate which can be set, to be notified of the changed selected item of the radio button. An alternative is to subscribe to the `publisher`.
    public weak var delegate: (any RadioButtonUIGroupViewDelegate)?

    /// A change of the selected item will be published. This is an alternative method to the `delegate` of being notified of changes to the selected item.
    public var publisher: any Publisher<ID, Never> {
        return self.currentValue
    }

    // MARK: Initializers
    /// Initializer of the radio button ui group component.
    /// Parameters:
    /// - theme: The current theme.
    /// - title: The title of the radio button group. This is optional, if it's not given, no title will be shown.
    /// - selectedID: The current selected value of the radio button group.
    /// - items: A list of `RadioButtonItem` which represent each item in the radio button group.
    /// - radioButtonLabelPosition: The position of the label in each radio button item according to the toggle. The default value is, that the label is to the `right` of the toggle.
    /// - groupLayout: The layout of the items within the group. These can be `horizontal` or `vertical`. The defalt is `vertical`.
    public init(theme: Theme,
                title: String? = nil,
                selectedID: ID,
                items: [RadioButtonUIItem<ID>],
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
        self.currentValue = CurrentValueSubject(selectedID)
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
            let radioButtonView = RadioButtonUIView(theme: theme,
                                                    id: $0.id,
                                                    label: $0.label,
                                                    selectedID: self.backingSelectedID,
                                                    state: $0.state,
                                                    labelPosition: self.radioButtonLabelPosition
            )
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            return radioButtonView
        }

        if let title = self.title {
            self.titleLabel.text = title
            self.titleLabel.font = self.theme.typography.subhead.uiFont
            self.titleLabel.textColor = self.theme.colors.base.onSurface.uiColor

            self.addSubview(self.titleLabel)
        }

        for radioButtonView in radioButtonViews {
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

    private func setupVerticalConstraints() {
        var previousLayoutTopAnchor = self.safeAreaLayoutGuide.topAnchor
        var constraints = [NSLayoutConstraint]()
        var spacing: CGFloat = 0

        if self.title != nil {
            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            previousLayoutTopAnchor = self.titleLabel.bottomAnchor
            spacing = self.spacing
        }

        for radioButtonView in radioButtonViews {
            constraints.append(radioButtonView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(radioButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

            let itemConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: spacing)
            constraints.append(itemConstraint)
            if spacing != 0 {
                self.itemSpacingConstraints.append(itemConstraint)
            }
            spacing = self.spacing

            previousLayoutTopAnchor = radioButtonView.bottomAnchor
        }

        constraints.append(previousLayoutTopAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

        self.allConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }

    private func setupHorizontalConstraints() {
        var previousLayoutTopAnchor = self.safeAreaLayoutGuide.topAnchor
        var previousLayoutLeadingAnchor = self.safeAreaLayoutGuide.leadingAnchor
        var constraints = [NSLayoutConstraint]()
        var spacing: CGFloat = 0

        if self.title != nil {
            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor))
            previousLayoutTopAnchor = self.titleLabel.bottomAnchor
            spacing = self.spacing
        }

        for (index, radioButtonView) in radioButtonViews.enumerated() {
            let topConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: spacing)
            if spacing != 0 {
                self.itemSpacingConstraints.append(topConstraint)
            }
            constraints.append(topConstraint)
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
