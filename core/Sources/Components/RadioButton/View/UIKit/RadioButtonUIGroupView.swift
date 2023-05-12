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

    // MARK: - Properties
    private var selectedID: Binding<ID>
    private let theme: Theme
    private let items: [RadioButtonItem<ID>]
    private let title: String?
    private let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
    private var itemConstraints = [NSLayoutConstraint]()

    var spacing: CGFloat {
        return self.bodyFontMetrics.scaledValue(
            for: (self.theme.layout.spacing.xLarge - 16),
            compatibleWith: traitCollection)
    }

    private var stackView = UIStackView()
    private lazy var backingSelectedID: Binding<ID> = Binding(
        get: {
            return self.selectedID.wrappedValue
        },
        set: { newValue in
            self.selectedID.wrappedValue = newValue
            self.updateRadioButtonStates(newValue: newValue)
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
                items: [RadioButtonItem<ID>]) {
        self.theme = theme
        self.items = items
        self.selectedID = selectedID
        self.title = title
        super.init(frame: .zero)

        arrangeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

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
                              selectedId: self.backingSelectedID,
                              state: $0.state)
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

    private func updateRadioButtonStates(newValue: ID) {
        for radioButtonView in self.radioButtonViews {
            radioButtonView.toggleNeedsRedisplay(newValue)
        }
    }
}
