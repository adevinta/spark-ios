//
//  FormFieldUIView.swift
//  SparkCore
//
//  Created by alican.aycil on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

/// The `FormFieldUIView`renders a component with title and subtitle using UIKit.
public final class FormFieldUIView<Component: UIControl>: UIControl {

    // MARK: - Private Properties.

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = self.spacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var cancellables = Set<AnyCancellable>()
    @ScaledUIMetric private var spacing: CGFloat

    // MARK: - Public properties.

    /// The title of formfield.
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.viewModel.setTitle(newValue.map(NSAttributedString.init))
        }
    }

    /// The attributedTitle of formfield.
    public var attributedTitle: NSAttributedString? {
        get {
            return self.titleLabel.attributedText
        }
        set {
            self.viewModel.setTitle(newValue)
        }
    }

    public var isTitleRequired: Bool {
        get {
            return self.viewModel.isTitleRequired
        }
        set {
            self.viewModel.isTitleRequired = newValue
        }
    }

    /// The description of formfield.
    public var descriptionString: String? {
        get {
            return self.descriptionLabel.text
        }
        set {
            self.viewModel.description = newValue.map(NSAttributedString.init)
        }
    }

    /// The attributedDescription of formfield.
    public var attributedDescription: NSAttributedString? {
        get {
            return self.descriptionLabel.attributedText
        }
        set {
            self.viewModel.description = newValue
        }
    }

    /// Returns the theme of the formfield.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    /// Returns the theme of the formfield.
    public var feedbackState: FormFieldFeedbackState {
        get {
            return self.viewModel.feedbackState
        }
        set {
            self.viewModel.feedbackState = newValue
        }
    }

    /// The current state of the component.
    public override var isEnabled: Bool {
        get {
            return self.component.isEnabled
        }
        set {
            self.component.isEnabled = newValue
        }
    }

    public override var isHighlighted: Bool {
        get {
            return self.component.isHighlighted
        }
        set {
            self.component.isHighlighted = newValue
        }
    }

    /// The current selection state of the component.
    public override var isSelected: Bool {
        get {
            return self.component.isSelected
        }
        set {
            self.component.isSelected = newValue
        }
    }

    /// The component of formfield.
    public var component: Component {
        didSet {
            oldValue.removeFromSuperview()
            self.component.isAccessibilityElement = true
            self.stackView.insertArrangedSubview(self.component, at: 1)
        }
    }

    var viewModel: FormFieldViewModel<NSAttributedString>

    // MARK: - Initialization

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - title: The formfield title.
    ///   - description: The formfield helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    ///   - isEnabled: The formfield's component isEnabled value.
    ///   - isSelected: The formfield's component isSelected state.
    public convenience init(
        theme: Theme,
        component: Component,
        feedbackState: FormFieldFeedbackState = .default,
        title: String? = nil,
        description: String? = nil,
        isTitleRequired: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false
    ) {
        let attributedTitle: NSAttributedString? = title.map(NSAttributedString.init)
        let attributedDescription: NSAttributedString? = description.map(NSAttributedString.init)
        self.init(
            theme: theme,
            component: component,
            feedbackState: feedbackState,
            attributedTitle: attributedTitle,
            attributedDescription: attributedDescription,
            isTitleRequired: isTitleRequired,
            isEnabled: isEnabled,
            isSelected: isSelected
        )
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - component: The component is covered by formfield.
    ///   - feedbackState: The formfield feedback state. 'Default' or 'Error'.
    ///   - attributedTitle: The formfield attributedTitle.
    ///   - attributedDescription: The formfield attributed helper message.
    ///   - isTitleRequired: The asterisk symbol at the end of title.
    ///   - isEnabled: The formfield's component isEnabled value.
    ///   - isSelected: The formfield's component isSelected state.
    public init(
        theme: Theme,
        component: Component,
        feedbackState: FormFieldFeedbackState = .default,
        attributedTitle: NSAttributedString? = nil,
        attributedDescription: NSAttributedString? = nil,
        isTitleRequired: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false
    ) {
        let viewModel = FormFieldViewModel<NSAttributedString>(
            theme: theme,
            feedbackState: feedbackState,
            title: attributedTitle,
            description: attributedDescription,
            isTitleRequired: isTitleRequired
        )

        self.viewModel = viewModel
        self.spacing = viewModel.spacing
        self.component = component

        super.init(frame: .zero)

        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.commonInit()
    }

    private func commonInit() {
        self.accessibilityIdentifier = FormFieldAccessibilityIdentifier.formField
        self.setupViews()
        self.subscribe()
    }

    private func setupViews() {
        self.addSubview(self.stackView)
        NSLayoutConstraint.stickEdges(from: self.stackView, to: self)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else { return }

        self._spacing.update(traitCollection: traitCollection)
        self.stackView.spacing = self.spacing
    }

    private func subscribe() {

        Publishers.CombineLatest3(
            self.viewModel.$title,
            self.viewModel.$titleFont,
            self.viewModel.$titleColor
        ).subscribe(in: &self.cancellables) { [weak self] title, font, color in
            guard let self else { return }
            let labelHidden: Bool = (title?.string ?? "").isEmpty
            self.titleLabel.isHidden = labelHidden
            self.titleLabel.font = font.uiFont
            self.titleLabel.textColor = color.uiColor
            self.titleLabel.attributedText = title
        }

        Publishers.CombineLatest3(
            self.viewModel.$description,
            self.viewModel.$descriptionFont,
            self.viewModel.$descriptionColor
        ).subscribe(in: &self.cancellables) { [weak self] title, font, color in
            guard let self else { return }
            let labelHidden: Bool = (title?.string ?? "").isEmpty
            self.descriptionLabel.isHidden = labelHidden
            self.descriptionLabel.font = font.uiFont
            self.descriptionLabel.textColor = color.uiColor
            self.descriptionLabel.attributedText = title
        }

        self.viewModel.$spacing.subscribe(in: &self.cancellables) { [weak self] spacing in
            guard let self = self else { return }
            self._spacing.wrappedValue = spacing
            self.stackView.spacing = self.spacing
        }
    }
}
