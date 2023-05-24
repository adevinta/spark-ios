//
//  BadgeUIView.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// This is the UIKit version for the ``BadgeView``
public class BadgeUIView: UIView {

    private var viewModel: BadgeViewModel

    /// Constraints for badge size in empty state
    /// In this case badge is shown like a circle
    private var emptyHeightConstraint: NSLayoutConstraint?
    private var emptyWidthConstraint: NSLayoutConstraint?

    /// Dynamicaly sized properties for badge
    /// ``emptyBadgeSize`` represents size of the circle in empty state of Badge
    ///
    /// ``horizontalSpacing`` and ``verticalSpacing`` are properties
    /// that used for space between badge background and text
    @ScaledUIMetric private var emptyBadgeSize: CGFloat = 0
    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var verticalSpacing: CGFloat = 0
    @ScaledUIMetric private var borderWidth: CGFloat = 0

    private var badgeLabel: UILabel = UILabel()

    /// Constraints for badge in non-empty state.
    /// All of them are set to the badge text label
    /// After that Badge view size is based on the size of the text
    private var badgeTopConstraint: NSLayoutConstraint?
    private var badgeLeadingConstraint: NSLayoutConstraint?
    private var badgeTrailingConstraint: NSLayoutConstraint?
    private var badgeBottomConstraint: NSLayoutConstraint?
    private var badgeWidthConstraint: NSLayoutConstraint?
    private var badgeHeightConstraint: NSLayoutConstraint?
    private var badgeConstraints: [NSLayoutConstraint?] {
        [badgeTopConstraint, badgeLeadingConstraint, badgeTrailingConstraint, badgeBottomConstraint, badgeWidthConstraint, badgeHeightConstraint]
    }

    // MARK: - Init

    public init(viewModel: BadgeViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        self.setupBadge()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    // MARK: - Badge configuration

    private func setupBadge() {
        setupScalables()
        setupBadgeText()
        setupAppearance()
        setupLayouts()
    }

    private func setupBadgeText() {
        self.addSubview(badgeLabel)
        self.badgeLabel.accessibilityIdentifier = BadgeAccessibilityIdentifier.text
        self.badgeLabel.adjustsFontForContentSizeCategory = true
        self.badgeLabel.textAlignment = .center
        self.badgeLabel.text = self.viewModel.text
        self.badgeLabel.textColor = self.viewModel.textColor.uiColor
        self.badgeLabel.font = self.viewModel.textFont.uiFont
        self.badgeLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.viewModel.badgeBorder.color.uiColor.cgColor
        self.clipsToBounds = true
    }

    private func setupScalables() {
        if self.viewModel.text.isEmpty {
            self.emptyBadgeSize = BadgeConstants.emptySize.width
        } else {
            self.horizontalSpacing = self.viewModel.horizontalOffset
            self.verticalSpacing = self.viewModel.verticalOffset
        }
        self.borderWidth = self.viewModel.badgeBorder.width
    }

    // MARK: - Layouts setup

    private func setupLayouts() {
        if self.viewModel.text.isEmpty {
            self.setupEmptySizeConstraints()
        } else {
            let textSize = badgeLabel.intrinsicContentSize
            self.setupBadgeConstraints(for: textSize)
        }
    }

    private func setupEmptySizeConstraints() {
        if let emptyHeightConstraint {
            emptyHeightConstraint.constant = emptyBadgeSize
        } else {
            self.emptyHeightConstraint = self.heightAnchor.constraint(equalToConstant: emptyBadgeSize)
            self.emptyHeightConstraint?.isActive = true
        }
        if let emptyWidthConstraint {
            emptyWidthConstraint.constant = emptyBadgeSize
        } else {
            self.emptyWidthConstraint = self.widthAnchor.constraint(equalToConstant: emptyBadgeSize)
            self.emptyWidthConstraint?.isActive = true
        }
    }

    private func setupBadgeConstraints(for textSize: CGSize) {
        if let badgeTopConstraint, let badgeBottomConstraint, let badgeLeadingConstraint, let badgeTrailingConstraint, let badgeWidthConstraint, let badgeHeightConstraint {
            badgeLeadingConstraint.constant = self.horizontalSpacing
            badgeTrailingConstraint.constant = -self.horizontalSpacing
            badgeTopConstraint.constant = self.verticalSpacing
            badgeBottomConstraint.constant = -self.verticalSpacing
            badgeWidthConstraint.constant = textSize.width
            badgeHeightConstraint.constant = textSize.height
        } else {
            badgeLeadingConstraint = badgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.horizontalSpacing)
            badgeTopConstraint = badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: self.verticalSpacing)
            badgeTrailingConstraint = badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -self.horizontalSpacing)
            badgeBottomConstraint = badgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.verticalSpacing)
            badgeWidthConstraint = badgeLabel.widthAnchor.constraint(equalToConstant: textSize.width)
            badgeHeightConstraint = badgeLabel.heightAnchor.constraint(equalToConstant: textSize.height)
            NSLayoutConstraint.activate(badgeConstraints.compactMap({ $0 }))
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = frame.height / 2.0
    }

    // MARK: - Updates on Trait Collection Change

    private func reloadColors() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        badgeLabel.textColor = self.viewModel.textColor.uiColor
        self.layer.borderColor = self.viewModel.badgeBorder.color.uiColor.cgColor
    }

    private func reloadBadgeFontIfNeeded() {
        guard !self.viewModel.text.isEmpty else {
            return
        }
        self.badgeLabel.font = self.viewModel.textFont.uiFont
    }

    private func reloadUISize() {
        if self.viewModel.text.isEmpty {
            self._emptyBadgeSize.update(traitCollection: self.traitCollection)
        } else {
            self._horizontalSpacing.update(traitCollection: self.traitCollection)
            self._verticalSpacing.update(traitCollection: self.traitCollection)
        }
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
