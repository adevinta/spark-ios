//
//  BadgeUIView.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// This is the UIKit version for the ``BadgeView``
public class BadgeUIView: UIView {

    private var viewModel: BadgeViewModel

    // Dynamicaly sized properties for badge
    // emptyBadgeSize represents size of the circle in empty state of Badge
    // horizontalSpacing and verticalSpacing are properties
    // that are used for space between badge background and text
    @ScaledUIMetric private var emptyBadgeSize: CGFloat = 0
    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var verticalSpacing: CGFloat = 0
    @ScaledUIMetric private var borderWidth: CGFloat = 0
    @ScaledUIMetric private var badgeHeight: CGFloat = 0

    // Constraints for badge size
    // Thess constraints containes text size with
    // vertical and horizontal offsets
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var sizeConstraints: [NSLayoutConstraint?] {
        [widthConstraint, heightConstraint]
    }

    // Constraints for attach / detach
    private var attachLeadingAnchorConstraint: NSLayoutConstraint?
    private var attachCenterXAnchorConstraint: NSLayoutConstraint?
    private var attachCenterYAnchorConstraint: NSLayoutConstraint?
    private var attachConstraints: [NSLayoutConstraint?] {
        [attachLeadingAnchorConstraint, attachCenterXAnchorConstraint, attachCenterYAnchorConstraint]
    }

    // MARK: - Badge Text Label properties
    private var textLabel: UILabel = UILabel()

    // Constraints for badge text label.
    // All of these are applied to the badge text label
    private var labelTopConstraint: NSLayoutConstraint?
    private var labelLeadingConstraint: NSLayoutConstraint?
    private var labelTrailingConstraint: NSLayoutConstraint?
    private var labelBottomConstraint: NSLayoutConstraint?

    // Array of badge text label constraints for
    // easier activation
    private var labelConstraints: [NSLayoutConstraint?] {
        [labelTopConstraint, labelLeadingConstraint, labelTrailingConstraint, labelBottomConstraint]
    }

    // Bool property that determines wether we should
    // install and activate text label constraints or not
    private var shouldSetupLabelConstrains: Bool {
        self.labelTopConstraint == nil ||
        self.labelBottomConstraint == nil ||
        self.labelLeadingConstraint == nil ||
        self.labelTrailingConstraint == nil
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Public variables
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    public var intent: BadgeIntentType {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var size: BadgeSize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.size = newValue
        }
    }

    public var value: Int? {
        get {
            return self.viewModel.value
        }
        set {
            self.viewModel.value = newValue
        }
    }

    public var format: BadgeFormat {
        get {
            return self.viewModel.format
        }
        set {
            self.viewModel.format = newValue
        }
    }

    public var isBorderVisible: Bool {
        get {
            return self.viewModel.isBorderVisible
        }
        set {
            self.viewModel.isBorderVisible = newValue
        }
    }
    // MARK: - Init

    public init(theme: Theme, intent: BadgeIntentType, size: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isBorderVisible: Bool = true) {
        self.viewModel = BadgeViewModel(theme: theme, intent: intent, size: size, value: value, format: format, isBorderVisible: isBorderVisible)

        super.init(frame: .zero)

        self.setupBadge()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    // MARK: - Badge configuration

    private func setupBadge() {
        setupScalables()
        setupBadgeText()
        setupAppearance()
        setupLayouts()
        subscribe()
    }

    private func setupScalables() {
        self.emptyBadgeSize = BadgeConstants.emptySize.width
        self.badgeHeight = BadgeConstants.height
        self.horizontalSpacing = self.viewModel.horizontalOffset
        self.verticalSpacing = self.viewModel.verticalOffset
        self.borderWidth = self.viewModel.isBorderVisible ? self.viewModel.border.width : .zero
    }

    private func setupBadgeText() {
        self.addSubview(textLabel)
        self.textLabel.setContentCompressionResistancePriority(.required,
                                                           for: .vertical)
        self.textLabel.setContentCompressionResistancePriority(.required,
                                                           for: .horizontal)
        self.textLabel.accessibilityIdentifier = BadgeAccessibilityIdentifier.text
        self.textLabel.adjustsFontForContentSizeCategory = true
        self.textLabel.textAlignment = .center
        self.textLabel.text = self.viewModel.text
        self.textLabel.textColor = self.viewModel.textColor.uiColor
        self.textLabel.font = self.viewModel.textFont.uiFont
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.viewModel.border.color.uiColor.cgColor
        self.clipsToBounds = true
    }

    // MARK: - Layouts setup

    private func setupLayouts() {
        let textSize = textLabel.intrinsicContentSize

        self.setupSizeConstraint(for: textSize)
        self.setupBadgeConstraintsIfNeeded(for: textSize)
    }

    private func setupSizeConstraint(for textSize: CGSize) {
        let widht = self.viewModel.isBadgeEmpty ? self.emptyBadgeSize : textSize.width + (self.horizontalSpacing * 2)
        let height = self.viewModel.isBadgeEmpty ? self.emptyBadgeSize : self.badgeHeight

        if let widthConstraint, let heightConstraint {
            widthConstraint.constant = widht
            heightConstraint.constant = height
        } else {
            self.widthConstraint = self.widthAnchor.constraint(equalToConstant: widht)
            self.widthConstraint?.priority = .required
            self.heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
            self.heightConstraint?.priority = .required
            NSLayoutConstraint.activate(self.sizeConstraints.compactMap({ $0 }))
        }
    }

    private func setupBadgeConstraintsIfNeeded(for textSize: CGSize) {
        guard self.shouldSetupLabelConstrains else {
            return
        }

        self.labelLeadingConstraint = self.textLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.labelTopConstraint = self.textLabel.topAnchor.constraint(equalTo: topAnchor)
        self.labelTrailingConstraint = self.textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        self.labelBottomConstraint = self.textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate(self.labelConstraints.compactMap({ $0 }))
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = min(frame.width, frame.height) / 2.0
    }

    // MARK: - Attach / Detach

    /// Remove constraints from the view the badge was attached onto
    public func detach() {
        self.attachConstraints.compactMap({ $0 }).forEach {
            self.removeConstraint($0)
        }
    }

    /// Attach badge to another view by using constraints
    /// Triggers detach() if it was already attached to a view
    /// - Parameters:
    ///   - view: the targeted view to attach the badge onto
    ///   - position: position where the ``BadgeView`` can be attached
    public func attach(to view: UIView, position: BadgePosition) {
        self.detach()

        switch position {
        case .topTrailingCorner:
            self.attachCenterXAnchorConstraint = self.centerXAnchor.constraint(equalTo: view.trailingAnchor)
            self.attachCenterYAnchorConstraint = self.centerYAnchor.constraint(equalTo: view.topAnchor)
        case .trailing:
            self.attachLeadingAnchorConstraint = self.leadingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                               constant: self.viewModel.theme.layout.spacing.small)
            self.attachCenterYAnchorConstraint = self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        }

        NSLayoutConstraint.activate(self.attachConstraints.compactMap({ $0 }))
    }
}

// MARK: - Badge Subscribers
extension BadgeUIView {
    private func subscribe() {
        self.subscribeToTextChanges()
        self.subscribeToBorderChanges()
        self.subscribeToColorChanges()
    }

    private func subscribeToTextChanges() {
        self.viewModel.$text
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.textLabel.text = text
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
        self.viewModel.$textFont
            .receive(on: DispatchQueue.main)
            .sink { [weak self] textFont in
                self?.textLabel.font = textFont.uiFont
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
        self.viewModel.$isBadgeEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isBadgeOutlined in
                self?.textLabel.text = self?.viewModel.text
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
    }

    private func subscribeToBorderChanges() {
        self.viewModel.$isBorderVisible
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isBadgeOutlined in
                guard let self else {
                    return
                }
                self.updateBorder(self.viewModel.border)
            }
            .store(in: &cancellables)
        self.viewModel.$border
            .receive(on: DispatchQueue.main)
            .sink { [weak self] badgeBorder in
                self?.updateBorder(badgeBorder)
            }
            .store(in: &cancellables)
    }

    private func subscribeToColorChanges() {
        self.viewModel.$textColor
            .receive(on: DispatchQueue.main)
            .sink { [weak self] textColor in
                self?.textLabel.textColor = textColor.uiColor
            }
            .store(in: &cancellables)
        self.viewModel.$backgroundColor
            .receive(on: DispatchQueue.main)
            .sink { [weak self] backgroundColor in
                self?.backgroundColor = backgroundColor.uiColor
            }
            .store(in: &cancellables)
    }
}

// MARK: - Updates on Trait Collection Change
extension BadgeUIView {
    private func updateBorder(_ badgeBorder: BadgeBorder) {
        self.layer.borderColor = badgeBorder.color.uiColor.cgColor
        self.setupScalables()
        self.reloadBorderWidth()
    }

    private func reloadColors() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        self.textLabel.textColor = self.viewModel.textColor.uiColor
        self.layer.borderColor = self.viewModel.border.color.uiColor.cgColor
    }

    private func reloadBadgeFontIfNeeded() {
        guard !self.viewModel.isBadgeEmpty else {
            return
        }
        self.textLabel.font = self.viewModel.textFont.uiFont
    }

    private func reloadUISize() {
        if self.viewModel.isBadgeEmpty {
            self._emptyBadgeSize.update(traitCollection: self.traitCollection)
        } else {
            self._horizontalSpacing.update(traitCollection: self.traitCollection)
            self._verticalSpacing.update(traitCollection: self.traitCollection)
        }
        self._badgeHeight.update(traitCollection: traitCollection)
    }

    private func reloadBorderWidth() {
        self._borderWidth.update(traitCollection: self.traitCollection)
        self.layer.borderWidth = self.borderWidth
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.reloadColors()
        }

        self.reloadBadgeFontIfNeeded()
        self.reloadUISize()
        self.reloadBorderWidth()
        self.setupLayouts()
    }
}

// MARK: - Label priorities
public extension BadgeUIView {
    func setLabelContentCompressionResistancePriority(_ priority: UILayoutPriority,
                                                      for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentCompressionResistancePriority(priority,
                                                           for: axis)
    }

    func setLabelContentHuggingPriority(_ priority: UILayoutPriority,
                                        for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentHuggingPriority(priority,
                                             for: axis)
    }
}

// MARK: - Badge Update Functions
public extension BadgeUIView {
    func setIntent(_ intent: BadgeIntentType) {
        self.viewModel.intent = intent
    }

    func setBorderVisible(_ isBorderVisible: Bool) {
        self.viewModel.isBorderVisible = isBorderVisible
    }

    func setValue(_ value: Int?) {
        self.viewModel.value = value
    }

    func setFormat(_ format: BadgeFormat) {
        self.viewModel.format = format
    }

    func setSize(_ badgeSize: BadgeSize) {
        self.viewModel.size = badgeSize
    }

    func setTheme(_ theme: Theme) {
        self.viewModel.theme = theme
    }
}
