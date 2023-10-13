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
    // horizontalSpacing is the padding to the left and right of the text
    // borderWidth is the width of the border when it's shown
    // badgeHeight is the height of the badge
    @ScaledUIMetric private var emptyBadgeSize: CGFloat = 0
    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var borderWidth: CGFloat = 0
    @ScaledUIMetric private var badgeHeight: CGFloat = 0

    // Constraints for badge size
    // Thess constraints containes text size with
    // vertical and horizontal offsets
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

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
    private var labelLeadingConstraint: NSLayoutConstraint?
    private var labelTrailingConstraint: NSLayoutConstraint?

    // Bool property that determines wether we should
    // install and activate text label constraints or not
    private var shouldSetupLabelConstrains: Bool {
        self.labelLeadingConstraint == nil ||
        self.labelTrailingConstraint == nil
    }

    // MARK: - Public variables
    /// The current theme of the view
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
            self.themeDidUpdate()
        }
    }

    /// The current intent
    public var intent: BadgeIntentType {
        get {
            return self.viewModel.intent
        }
        set {
            guard self.viewModel.intent != newValue else { return }

            self.viewModel.intent = newValue
            self.intentDidUpdate()
        }
    }

    /// The badge size
    public var size: BadgeSize {
        get {
            return self.viewModel.size
        }
        set {
            guard self.viewModel.size != newValue else { return }

            self.viewModel.size = newValue
            self.sizeDidUpdate()
        }
    }

    /// The current value of the badge
    public var value: Int? {
        get {
            return self.viewModel.value
        }
        set {
            guard self.viewModel.value != newValue else { return }

            self.viewModel.value = newValue
            self.valueDidUpdate()
        }
    }

    /// The formatter of the badge
    public var format: BadgeFormat {
        get {
            return self.viewModel.format
        }
        set {
            guard self.viewModel.format != newValue else { return }

            self.viewModel.format = newValue
            self.formatDidUpdate()
        }
    }

    /// Shows/hides the border around the badge
    public var isBorderVisible: Bool {
        get {
            return self.viewModel.isBorderVisible
        }
        set {
            guard self.viewModel.isBorderVisible != newValue else { return }

            self.viewModel.isBorderVisible = newValue
            self.isBorderVisibleDidUpdate()
        }
    }

    public override var intrinsicContentSize: CGSize {
        if self.viewModel.isBadgeEmpty {
            return CGSize(width: self.emptyBadgeSize, height: self.emptyBadgeSize)
        } else {
            let height = self.badgeHeight
            let contentWidth = self.textLabel.intrinsicContentSize.width + (self.horizontalSpacing * 2)

            let width = max(contentWidth, height)
            return CGSize(width: width, height: height)
        }
    }

    // MARK: - Init
    public init(theme: Theme, intent: BadgeIntentType, size: BadgeSize = .medium, value: Int? = nil, format: BadgeFormat = .default, isBorderVisible: Bool = false) {
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
        updateScalables()
        setupBadgeText()
        setupAppearance()
        setupLayouts()
    }

    private func updateScalables() {
        self.emptyBadgeSize = BadgeConstants.emptySize.width
        self.badgeHeight = self.viewModel.badgeHeight
        self.horizontalSpacing = self.viewModel.offset.leading
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
        self.setupSizeConstraint()
        self.updateLeadingConstraintsIfNeeded()
        self.setupBadgeConstraintsIfNeeded()
    }

    private func setupSizeConstraint() {
        let badgeSize = self.viewModel.isBadgeEmpty ? self.emptyBadgeSize : self.badgeHeight

        if let heightConstraint = self.heightConstraint, let widthConstraint = self.widthConstraint {
            widthConstraint.constant = badgeSize
            heightConstraint.constant = badgeSize
        } else {
            let widthConstraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: badgeSize)
            widthConstraint.priority = .required
            let heightConstraint = self.heightAnchor.constraint(equalToConstant: badgeSize)
            heightConstraint.priority = .required
            NSLayoutConstraint.activate([widthConstraint, heightConstraint])
            self.widthConstraint = widthConstraint
            self.heightConstraint = heightConstraint
        }
    }

    private func updateLeadingConstraintsIfNeeded() {
        guard let leadingConstraint = self.labelLeadingConstraint,
              let trailingConstraint = self.labelTrailingConstraint else { return }

        let spacing: CGFloat = self.viewModel.isBadgeEmpty ? 0 : self.horizontalSpacing
        leadingConstraint.constant = spacing
        trailingConstraint.constant = -spacing
    }

    private func setupBadgeConstraintsIfNeeded() {
        guard self.shouldSetupLabelConstrains else {
            return
        }

        let labelLeadingConstraint = self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.horizontalSpacing)
        let labelTrailingConstraint = self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.horizontalSpacing)
        let centerYConstraint = self.textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([labelLeadingConstraint, labelTrailingConstraint, centerYConstraint])
        self.labelLeadingConstraint = labelLeadingConstraint
        self.labelTrailingConstraint = labelTrailingConstraint
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
            self.attachCenterXAnchorConstraint = self.centerXAnchor.constraint(
                equalTo: view.trailingAnchor)
            self.attachCenterYAnchorConstraint = self.centerYAnchor.constraint(
                equalTo: view.topAnchor)
        case .trailing:
            self.attachLeadingAnchorConstraint = self.leadingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: self.viewModel.theme.layout.spacing.small)
            self.attachCenterYAnchorConstraint = self.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        }

        NSLayoutConstraint.activate(self.attachConstraints.compactMap({ $0 }))
    }
}

// MARK: - Badge Updates
extension BadgeUIView {
    private func themeDidUpdate() {
        self.updateTextLabelColor()
        self.updateBackgroundColor()
        self.updateBorder()
        self.updateScalables()
        self.updateBadgeHeight()
    }

    private func intentDidUpdate() {
        self.updateTextLabelColor()
        self.updateBackgroundColor()
        self.updateBorder()
    }

    private func sizeDidUpdate() {
        self.updateTextFont()
        self.updateScalables()
        self.updateBadgeHeight()
    }

    private func valueDidUpdate() {
        self.updateTextLabel()
    }

    private func formatDidUpdate() {
        self.updateTextLabel()
    }

    private func isBorderVisibleDidUpdate() {
        self.updateBorder()
    }

    private func updateTextLabel() {
        self.textLabel.text = self.viewModel.text
        self.reloadUISize()
        self.setupLayouts()
    }

    private func updateTextFont() {
        self.textLabel.font = self.viewModel.textFont.uiFont
        self.reloadUISize()
        self.setupLayouts()
    }

    private func updateTextLabelColor() {
        self.textLabel.textColor = self.viewModel.textColor.uiColor
    }

    private func updateBackgroundColor() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
    }

    private func updateBadgeHeight() {
        self.badgeHeight = self.viewModel.badgeHeight
        self.setupLayouts()
        self.invalidateIntrinsicContentSize()
    }
}

// MARK: - Updates on Trait Collection Change
extension BadgeUIView {
    private func updateBorder() {
        let badgeBorder = self.viewModel.border
        self.layer.borderColor = badgeBorder.color.uiColor.cgColor
        self.updateScalables()
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
        self._emptyBadgeSize.update(traitCollection: self.traitCollection)
        self._horizontalSpacing.update(traitCollection: self.traitCollection)
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

        self.invalidateIntrinsicContentSize()
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
        self.intent = intent
    }

    func setBorderVisible(_ isBorderVisible: Bool) {
        self.isBorderVisible = isBorderVisible
    }

    func setValue(_ value: Int?) {
        self.value = value
    }

    func setFormat(_ format: BadgeFormat) {
        self.format = format
    }

    func setSize(_ badgeSize: BadgeSize) {
        self.size = badgeSize
    }

    func setTheme(_ theme: Theme) {
        self.theme = theme
    }
}
