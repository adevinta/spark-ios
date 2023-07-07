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
    private var itemSpacingConstraints = [NSLayoutConstraint]()
    private var itemLabelSpacingConstraints = [NSLayoutConstraint]()
    private var allConstraints = [NSLayoutConstraint]()
    private let valueSubject: PassthroughSubject<ID, Never>
    private let viewModel: RadioButtonGroupViewModel

    private var subscriptions = Set<AnyCancellable>()

    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var labelSpacing: CGFloat

    private lazy var backingSelectedID: Binding<ID> = Binding(
        get: {
            return self.selectedID
        },
        set: { newValue in
            self.selectedID = newValue
            self.valueSubject.send(newValue)
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

    private var supplementaryLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Public Properties
    public var items: [RadioButtonUIItem<ID>] {
        didSet {
            self.didUpdateItems()
        }
    }

    public var title: String? {
        didSet {
            if self.setTextOf(label: self.titleLabel,
                              title: self.title,
                              font: self.viewModel.titleFont.uiFont,
                              color: self.viewModel.titleColor.uiColor) {
                self.setupConstraints()
            }
        }
    }

    public var supplementaryText: String? {
        didSet {
            if self.setTextOf(label: self.supplementaryLabel,
                              title: self.supplementaryText,
                              font: self.viewModel.sublabelFont.uiFont,
                              color: self.viewModel.sublabelColor.uiColor) {
                self.setupConstraints()
            }
        }
    }

    public var state: RadioButtonGroupState {
        get {
            return self.viewModel.state
        }
        set {
            self.viewModel.state = newValue
            for radioButtonView in radioButtonViews {
                radioButtonView.groupState = newValue
            }
        }

    }

    /// The current selected ID. 
    public var selectedID: ID {
        didSet {
            self.updateRadioButtonStates()
        }
    }

    /// The current theme
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            for radioButtonView in radioButtonViews {
                radioButtonView.theme = newValue
            }
            self.viewModel.theme = newValue
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
            self.setupConstraints()
        }
    }

    /// A delegate which can be set, to be notified of the changed selected item of the radio button. An alternative is to subscribe to the `publisher`.
    public weak var delegate: (any RadioButtonUIGroupViewDelegate)?

    /// A change of the selected item will be published. This is an alternative method to the `delegate` of being notified of changes to the selected item.
    public var publisher: any Publisher<ID, Never> {
        return self.valueSubject
    }

    public override var accessibilityIdentifier: String? {
        didSet {
            guard let identifier = accessibilityIdentifier else { return }
            for (index, radioButtonView) in radioButtonViews.enumerated() {
                radioButtonView.accessibilityIdentifier = "\(identifier)-\(index)"
            }
        }
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
    /// - state: The state of the radiobutton group, see `RadioButtonGroupState`
    public convenience init(theme: Theme,
                title: String? = nil,
                selectedID: ID,
                items: [RadioButtonUIItem<ID>],
                radioButtonLabelPosition: RadioButtonLabelPosition = .right,
                groupLayout: RadioButtonGroupLayout = .vertical,
                state: RadioButtonGroupState = .enabled,
                supplementaryText: String? = nil) {
        let viewModel = RadioButtonGroupViewModel(theme: theme, state: state)
        self.init(viewModel: viewModel,
                  title: title,
                  selectedID: selectedID,
                  items: items,
                  radioButtonLabelPosition: radioButtonLabelPosition,
                  groupLayout: groupLayout,
                  supplementaryText: supplementaryText)
    }

    init(viewModel: RadioButtonGroupViewModel,
         title: String? = nil,
         selectedID: ID,
         items: [RadioButtonUIItem<ID>],
         radioButtonLabelPosition: RadioButtonLabelPosition = .right,
         groupLayout: RadioButtonGroupLayout = .vertical,
         supplementaryText: String? = nil) {
        self.viewModel = viewModel
        self.items = items
        self.selectedID = selectedID
        self.title = title
        self.supplementaryText = supplementaryText
        self.radioButtonLabelPosition = radioButtonLabelPosition
        self.groupLayout = groupLayout
        self._spacing = ScaledUIMetric(wrappedValue: viewModel.spacing)
        self._labelSpacing = ScaledUIMetric(wrappedValue: viewModel.labelSpacing)
        self.valueSubject = PassthroughSubject()
        super.init(frame: .zero)

        arrangeView()
        setupConstraints()
        setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._spacing.update(traitCollection: self.traitCollection)
        self._labelSpacing.update(traitCollection: self.traitCollection)

        for constraint in self.itemSpacingConstraints {
            constraint.constant = self.spacing
        }

        for constraint in self.itemLabelSpacingConstraints {
            constraint.constant = self.labelSpacing
        }
    }

    // MARK: Private Methods

    private func arrangeView() {
        self.createRadioButtonViews()

        self.setTextOf(label: self.titleLabel,
                       title: self.title,
                       font: self.viewModel.titleFont.uiFont,
                       color: self.viewModel.titleColor.uiColor)

        for radioButtonView in radioButtonViews {
            self.addSubview(radioButtonView)
        }

        self.setTextOf(label: self.supplementaryLabel,
                       title: self.supplementaryText,
                       font: self.viewModel.sublabelFont.uiFont,
                       color: self.viewModel.sublabelColor.uiColor)
    }

    private func didUpdateItems() {
        NSLayoutConstraint.deactivate(self.allConstraints)
        for view in self.radioButtonViews {
            view.removeFromSuperview()
        }
        createRadioButtonViews()
        for radioButtonView in radioButtonViews {
            self.addSubview(radioButtonView)
        }
        setupConstraints()
    }

    private func createRadioButtonViews() {
        self.radioButtonViews = items.map {
            let radioButtonView = RadioButtonUIView(theme: theme,
                                                    id: $0.id,
                                                    label: $0.label,
                                                    selectedID: self.backingSelectedID,
                                                    groupState: self.viewModel.state,
                                                    labelPosition: self.radioButtonLabelPosition
            )
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            return radioButtonView
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.deactivate(self.allConstraints)

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
            spacing = self.labelSpacing
        }

        for (index, radioButtonView) in radioButtonViews.enumerated() {
            constraints.append(radioButtonView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(radioButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

            let itemConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: spacing)
            constraints.append(itemConstraint)
            if spacing != 0 {
                if index == 0 {
                    self.itemLabelSpacingConstraints.append(itemConstraint)
                } else {
                    self.itemSpacingConstraints.append(itemConstraint)
                }
            }
            spacing = self.spacing

            previousLayoutTopAnchor = radioButtonView.bottomAnchor
        }

        if self.supplementaryText !=  nil {
            constraints.append(self.supplementaryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.supplementaryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            let topConstraint = self.supplementaryLabel.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: self.labelSpacing)
            constraints.append(topConstraint)
            self.itemLabelSpacingConstraints.append(topConstraint)
            previousLayoutTopAnchor = self.supplementaryLabel.bottomAnchor
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
            spacing = self.labelSpacing
        }

        var radioButtonAnchors = [NSLayoutYAxisAnchor]()

        for (index, radioButtonView) in radioButtonViews.enumerated() {
            let topConstraint = radioButtonView.topAnchor.constraint(equalTo: previousLayoutTopAnchor, constant: spacing)
            if spacing != 0 {
                self.itemLabelSpacingConstraints.append(topConstraint)
            }
            constraints.append(topConstraint)
            radioButtonAnchors.append(radioButtonView.bottomAnchor)

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

        var bottomAnchor: NSLayoutYAxisAnchor = self.safeAreaLayoutGuide.bottomAnchor
        var labelSpacing: CGFloat = 0

        if self.supplementaryText !=  nil {
            bottomAnchor = self.supplementaryLabel.topAnchor
            labelSpacing = self.labelSpacing
            constraints.append(self.supplementaryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.supplementaryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.supplementaryLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
        }

        for anchor in radioButtonAnchors {
            let bottomConstraint = bottomAnchor.constraint(equalTo: anchor, constant: labelSpacing)
            constraints.append(bottomConstraint)
            if labelSpacing != 0 {
                self.itemLabelSpacingConstraints.append(bottomConstraint)
            }
        }

        self.allConstraints = constraints
        NSLayoutConstraint.activate(constraints)
    }

    private func setupSubscriptions() {
        self.viewModel.$titleFont.subscribe(in: &self.subscriptions) { [weak self] font in
            self?.titleLabel.font = font.uiFont
        }

        self.viewModel.$titleColor.subscribe(in: &self.subscriptions) { [weak self] color in
            self?.titleLabel.textColor = color.uiColor
        }

        self.viewModel.$sublabelFont.subscribe(in: &self.subscriptions) { [weak self] font in
            self?.supplementaryLabel.font = font.uiFont
        }

        self.viewModel.$sublabelColor.subscribe(in: &self.subscriptions) { [weak self] color in
            self?.supplementaryLabel.textColor = color.uiColor
        }

        self.viewModel.$spacing.subscribe(in: &self.subscriptions) { [weak self] spacing in
            self?._spacing = ScaledUIMetric(wrappedValue: spacing)
            self?.updateConstraints()
        }

        self.viewModel.$labelSpacing.subscribe(in: &self.subscriptions) { [weak self] spacing in
            self?._labelSpacing = ScaledUIMetric(wrappedValue: spacing)
            self?.updateConstraints()
        }
    }
    
    private func updateRadioButtonStates() {
        for radioButtonView in self.radioButtonViews {
            radioButtonView.toggleNeedsRedisplay()
        }
    }

    @discardableResult
    private func setTextOf(label: UILabel,
                           title: String?,
                           font: UIFont,
                           color: UIColor) -> Bool {
        label.font = font
        label.textColor = color

        guard label.text != title else { return false }

        if label.text == nil {
            self.addSubview(label)
            label.text = title
            return true
        } else if title == nil {
            label.text = nil
            label.removeFromSuperview()
            return true
        } else {
            label.text = title
            return false
        }
    }
}
