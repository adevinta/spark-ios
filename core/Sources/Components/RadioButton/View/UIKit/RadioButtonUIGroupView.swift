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
    private var itemLabelSpacingConstraints = [NSLayoutConstraint]()
    private var allConstraints = [NSLayoutConstraint]()
    private let valueSubject: PassthroughSubject<ID, Never>
    private let viewModel: RadioButtonGroupViewModel<Void>

    private var subscriptions = Set<AnyCancellable>()

    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var labelSpacing: CGFloat

    private lazy var backingSelectedID: Binding<ID?> = Binding(
        get: {
            return self.selectedID
        },
        set: { newValue in
            guard let newValue = newValue else { return }
            self.selectedID = newValue
            self.updateRadioButtonStates()
            self.valueSubject.send(newValue)
            self.delegate?.radioButtonGroup(self, didChangeSelection: newValue)
        }
    )

    public private(set) var radioButtonViews: [RadioButtonUIView<ID>] = []

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = RadioButtonAccessibilityIdentifier.radioButtonGroupTitle
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var supplementaryLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Public Properties
    /// All the items `RadioButtonUIItem` of the radio button group
    public var items: [RadioButtonUIItem<ID>] {
        set {
            self.radioButtonViews = self.createRadioButtonViews(items: newValue)
            self.didUpdateItems()
        }
        get {
            self.radioButtonViews.map{
                if let attributedText = $0.attributedText {
                    return .init(id: $0.id, label: attributedText)
                } else {
                    return .init(id: $0.id, label: $0.text ?? "")
                }
            }
        }
    }

    public var isEnabled: Bool = true {
        didSet {
            self.radioButtonViews.forEach{ $0.isEnabled = self.isEnabled }
        }
    }

    /// The number of radio button items in the radio button group
    public var numberOfItems: Int {
        return self.radioButtonViews.count
    }

    /// An optional title of the radio button group
    public var title: String? {
        didSet {
            self.titleDidUpdate()
        }
    }

    /// An optional supplementary text of the radio button group rendered at the bottom of the group. This is NOT well defined for the states `enabled` and disabled.
    public var supplementaryText: String? {
        didSet {
            self.subtitleDidUpdate()
        }
    }

    /// The current state `RadioButtonGroupState` of the items within the group, e.g. `enabled`.
    @available(*, deprecated, message: "Use RadioButtonIntent and the attribute isEnabled instead. ")
    public var state: RadioButtonGroupState = .enabled {
        didSet {
            self.viewModel.intent = self.state.intent

            for radioButtonView in radioButtonViews {
                radioButtonView.intent = self.state.intent
                radioButtonView.isEnabled = self.state != .disabled
            }
        }

    }

    /// The current selected ID. 
    public var selectedID: ID? {
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

    /// The label position `RadioButtonLabelPosition` according to the toggle, either `left` or `right`. The default value is `.left`
    @available(*, deprecated, renamed: "alignment", message: "Please use alignment instead.")
    public var radioButtonLabelPosition: RadioButtonLabelPosition {
        get {
            return self.labelAlignment.position
        }
        set {
            self.labelAlignment = newValue.alignment
        }
    }

    /// The label position `RadioButtonLabelAlignment` according to the toggle, either `leading` or `trailing`. The default value is `.leading`
    public var labelAlignment: RadioButtonLabelAlignment {
        didSet {
            guard self.labelAlignment != oldValue else { return }

            for radioButtonView in radioButtonViews {
                radioButtonView.labelAlignment = labelAlignment
            }
        }
    }

    /// The group layout `RadioButtonGroupLayout` of the radio buttons, either `horizontal` or `vertical`. The default is `vertical`.
    public var groupLayout: RadioButtonGroupLayout {
        didSet {
            guard self.groupLayout != oldValue else { return }

            self.stackView.axis = self.groupLayout.axis
        }
    }

    /// The intent `RadioButtonIntent` defining the colors of the radio button.
    public var intent: RadioButtonIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
            for radioButtonView in radioButtonViews {
                radioButtonView.intent = newValue
            }
        }
    }

    /// A delegate which can be set, to be notified of the changed selected item of the radio button. An alternative is to subscribe to the `publisher`.
    public weak var delegate: (any RadioButtonUIGroupViewDelegate)?

    /// A change of the selected item will be published. This is an alternative method to the `delegate` of being notified of changes to the selected item.
    public var publisher: some Publisher<ID, Never> {
        return self.valueSubject
    }

    /// Set the accessibilityIdentifier. This identifier will be used as the accessibility identifier prefix of each radio button item, the suffix of that accessibility identifier being the index of the item within it's array.
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
    /// - items: A list of `RadioButtonUIItem` which represent each item in the radio button group.
    /// - radioButtonLabelPosition: The position of the label in each radio button item according to the toggle. The default value is, that the label is to the `right` of the toggle.
    /// - groupLayout: The layout of the items within the group. These can be `horizontal` or `vertical`. The defalt is `vertical`.
    /// - state: The state of the radiobutton group, see `RadioButtonGroupState`
    @available(*, deprecated, message: "Use initializer with intent instead. Title and subtitle are also deprececated.")
    public convenience init(theme: Theme,
                title: String? = nil,
                selectedID: ID,
                items: [RadioButtonUIItem<ID>],
                radioButtonLabelPosition: RadioButtonLabelPosition = .right,
                groupLayout: RadioButtonGroupLayout = .vertical,
                state: RadioButtonGroupState = .enabled,
                supplementaryText: String? = nil) {
        let viewModel = RadioButtonGroupViewModel(
            theme: theme,
            intent: state.intent,
            content: ()
        )

        self.init(viewModel: viewModel,
                  selectedID: selectedID,
                  items: items,
                  labelAlignment: radioButtonLabelPosition.alignment,
                  groupLayout: groupLayout)

        self.state = state
        self.title = title
        self.supplementaryText = supplementaryText
        self.titleDidUpdate()
        self.subtitleDidUpdate()
    }

    /// Initializer of the radio button ui group component.
    /// Parameters:
    /// - theme: The current theme.
    /// - intent: The default intent is `basic`
    /// - selectedID: The current selected value of the radio button group.
    /// - items: A list of `RadioButtonUIItem` which represent each item in the radio button group.
    /// - radioButtonLabelPosition: The position of the label in each radio button item according to the toggle. The default value is, that the label is to the `right` of the toggle.
    /// - groupLayout: The layout of the items within the group. These can be `horizontal` or `vertical`. The defalt is `vertical`.
    public convenience init(
        theme: Theme,
        intent: RadioButtonIntent,
        selectedID: ID?,
        items: [RadioButtonUIItem<ID>],
        labelAlignment: RadioButtonLabelAlignment = .trailing,
        groupLayout: RadioButtonGroupLayout = .vertical) {

        let viewModel = RadioButtonGroupViewModel<Void>(
            theme: theme,
            intent: intent,
            content: ()
        )

        self.init(
            viewModel: viewModel,
            selectedID: selectedID,
            items: items,
            labelAlignment: labelAlignment,
            groupLayout: groupLayout)
    }

    init(viewModel: RadioButtonGroupViewModel<Void>,
         selectedID: ID?,
         items: [RadioButtonUIItem<ID>],
         labelAlignment: RadioButtonLabelAlignment = .trailing,
         groupLayout: RadioButtonGroupLayout = .vertical) {
        self.viewModel = viewModel
        self.selectedID = selectedID
        self.labelAlignment = labelAlignment
        self.groupLayout = groupLayout
        self._spacing = ScaledUIMetric(wrappedValue: viewModel.spacing)
        self._labelSpacing = ScaledUIMetric(wrappedValue: viewModel.labelSpacing)
        self.valueSubject = PassthroughSubject()

        super.init(frame: .zero)
        self.items = items

        self.stackView.spacing = self.spacing
        self.stackView.axis = groupLayout.axis
        self.setupView()
        self.setupConstraints()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._spacing.update(traitCollection: self.traitCollection)
        self._labelSpacing.update(traitCollection: self.traitCollection)

        self.stackView.spacing = self.spacing

        for constraint in self.itemLabelSpacingConstraints {
            constraint.constant = self.labelSpacing
        }
    }

    // MARK: Item Control
    public func setTitle(_ title: String, forItemAt index: Int) {
        guard index < self.radioButtonViews.count else { return }

        self.radioButtonViews[safe: index]?.text = title
    }

    public func setTitle(_ title: NSAttributedString, forItemAt index: Int) {
        guard index < self.radioButtonViews.count else { return }

        self.radioButtonViews[safe: index]?.attributedText = title
    }

    public func addRadioButton(_ item: RadioButtonUIItem<ID>,  atIndex index: Int = Int.max) {

        var items = self.items
        if index < items.count {
            items[index] = item
        } else {
            items.append(item)
        }

        self.items = items
    }

    public func removeRadioButton(at index: Int, animated: Bool = false) {
        guard index < self.radioButtonViews.count else { return }
        var items = self.items
        items.remove(at: index)

        self.items = items
    }

    // MARK: Private Methods

    private func setupView() {

        self.addSubview(self.titleLabel)
        self.setTextOf(label: self.titleLabel,
                       title: self.title,
                       font: self.viewModel.titleFont.uiFont,
                       color: self.viewModel.titleColor.uiColor)

        self.stackView.addArrangedSubviews(self.radioButtonViews)
        self.addSubview(self.stackView)

        self.addSubview(self.supplementaryLabel)
        self.setTextOf(label: self.supplementaryLabel,
                       title: self.supplementaryText,
                       font: self.viewModel.sublabelFont.uiFont,
                       color: self.viewModel.sublabelColor.uiColor)
    }

    private func didUpdateItems() {
        self.stackView.removeArrangedSubviews()
        self.stackView.addArrangedSubviews(self.radioButtonViews)
    }

    private func createRadioButtonViews(
        items: [RadioButtonUIItem<ID>]) -> [RadioButtonUIView<ID>] {
         let radioButtonViews = items.map {
            let radioButtonView = RadioButtonUIView(
                theme: self.theme,
                intent: self.viewModel.intent,
                id: $0.id,
                label: $0.label,
                selectedID: self.backingSelectedID,
                labelAlignment: self.labelAlignment
            )
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            return radioButtonView
        }
        return radioButtonViews
    }

    private func setupConstraints() {
        NSLayoutConstraint.deactivate(self.allConstraints)
        var constraints = [NSLayoutConstraint]()

        if self.title != nil {
            constraints.append(self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor))
            let titleSpacingConstraint = self.titleLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -self.labelSpacing)
            self.itemLabelSpacingConstraints = [titleSpacingConstraint]

            constraints.append(titleSpacingConstraint)

        } else {
            constraints.append(self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor))
            self.itemLabelSpacingConstraints = []
        }

        constraints.append(self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))

        if self.supplementaryText != nil {
            constraints.append(self.supplementaryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(self.supplementaryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(self.supplementaryLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

            let supplementaryLabelSpacingConstraints = self.supplementaryLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: self.labelSpacing)
            self.itemLabelSpacingConstraints.append(supplementaryLabelSpacingConstraints)

            constraints.append(supplementaryLabelSpacingConstraints)
        } else {
            constraints.append(self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
        }

        NSLayoutConstraint.activate(constraints)
        self.allConstraints = constraints
    }

    private func titleDidUpdate() {
        if self.setTextOf(label: self.titleLabel,
                          title: self.title,
                          font: self.viewModel.titleFont.uiFont,
                          color: self.viewModel.titleColor.uiColor) {
            self.setupConstraints()
        }
    }

    private func subtitleDidUpdate() {
        if self.setTextOf(
            label: self.supplementaryLabel,
            title: self.supplementaryText,
            font: self.viewModel.sublabelFont.uiFont,
            color: self.viewModel.sublabelColor.uiColor) {
            self.setupConstraints()
        }
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
            label.isHidden = false
            label.text = title
            return true
        } else if title == nil {
            label.text = nil
            label.isHidden = true
            return true
        } else {
            label.text = title
            return false
        }
    }
}

private extension RadioButtonGroupLayout {
    var axis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal: return .horizontal
        case .vertical: return .vertical
        }
    }
}
