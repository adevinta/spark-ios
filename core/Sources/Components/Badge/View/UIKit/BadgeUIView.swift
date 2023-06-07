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
    // that used for space between badge background and text
    @ScaledUIMetric private var emptyBadgeSize: CGFloat = 0
    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var verticalSpacing: CGFloat = 0
    @ScaledUIMetric private var borderWidth: CGFloat = 0

    // Constraints for badge size
    // Thess constraints containes text size with
    // vertical and horizontal offsets
    private var badgeWidthConstraint: NSLayoutConstraint?
    private var badgeHeightConstraint: NSLayoutConstraint?
    private var badgeSizeConstraints: [NSLayoutConstraint?] {
        [badgeWidthConstraint, badgeHeightConstraint]
    }

    // MARK: - Badge Text Label properties
    private var badgeLabel: UILabel = UILabel()

    // Constraints for badge text label.
    // All of these are applied to the badge text label
    private var badgeLabelTopConstraint: NSLayoutConstraint?
    private var badgeLabelLeadingConstraint: NSLayoutConstraint?
    private var badgeLabelTrailingConstraint: NSLayoutConstraint?
    private var badgeLabelBottomConstraint: NSLayoutConstraint?

    // Array of badge text label constraints for
    // easier activation
    private var badgeLabelConstraints: [NSLayoutConstraint?] {
        [badgeLabelTopConstraint, badgeLabelLeadingConstraint, badgeLabelTrailingConstraint, badgeLabelBottomConstraint]
    }

    // Bool property that determines wether we should
    // install and activate text label constraints or not
    private var shouldSetupLabelConstrains: Bool {
        self.badgeLabelTopConstraint == nil ||
        self.badgeLabelBottomConstraint == nil ||
        self.badgeLabelLeadingConstraint == nil ||
        self.badgeLabelTrailingConstraint == nil
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    public init(theme: Theme, badgeType: BadgeIntentType, badgeSize: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isOutlined: Bool = true) {
        self.viewModel = BadgeViewModel(theme: theme, badgeType: badgeType, badgeSize: badgeSize, value: value, format: format, isOutlined: isOutlined)

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
        subscribe()
    }

    private func setupScalables() {
        self.emptyBadgeSize = BadgeConstants.emptySize.width
        self.horizontalSpacing = self.viewModel.horizontalOffset
        self.verticalSpacing = self.viewModel.verticalOffset
        self.borderWidth = self.viewModel.badgeBorder.width
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

    // MARK: - Layouts setup

    private func setupLayouts() {
        let textSize = badgeLabel.intrinsicContentSize

        self.setupSizeConstraint(for: textSize)
        self.setupBadgeConstraintsIfNeeded(for: textSize)
    }

    private func setupSizeConstraint(for textSize: CGSize) {
        let widht = self.viewModel.isBadgeEmpty ? self.emptyBadgeSize : textSize.width + (self.horizontalSpacing * 2)
        let height = self.viewModel.isBadgeEmpty ? self.emptyBadgeSize : textSize.height + (self.verticalSpacing * 2)

        if let badgeWidthConstraint, let badgeHeightConstraint {
            badgeWidthConstraint.constant = widht
            badgeHeightConstraint.constant = height
        } else {
            self.badgeWidthConstraint = self.widthAnchor.constraint(equalToConstant: widht)
            self.badgeHeightConstraint = self.heightAnchor.constraint(equalToConstant: height)
            NSLayoutConstraint.activate(badgeSizeConstraints.compactMap({ $0 }))
        }
    }

    private func setupBadgeConstraintsIfNeeded(for textSize: CGSize) {
        guard shouldSetupLabelConstrains else {
            return
        }

        self.badgeLabelLeadingConstraint = self.badgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.badgeLabelTopConstraint = self.badgeLabel.topAnchor.constraint(equalTo: topAnchor)
        self.badgeLabelTrailingConstraint = self.badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        self.badgeLabelBottomConstraint = self.badgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate(badgeLabelConstraints.compactMap({ $0 }))
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = min(frame.width, frame.height) / 2.0
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
                self?.badgeLabel.text = text
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
        self.viewModel.$textFont
            .receive(on: DispatchQueue.main)
            .sink { [weak self] textFont in
                self?.badgeLabel.font = textFont.uiFont
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
        self.viewModel.$isBadgeEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isBadgeOutlined in
                self?.badgeLabel.text = self?.viewModel.text
                self?.reloadUISize()
                self?.setupLayouts()
            }
            .store(in: &cancellables)
    }

    private func subscribeToBorderChanges() {
        self.viewModel.$isBadgeOutlined
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isBadgeOutlined in
                guard let self else {
                    return
                }
                self.updateBorder(self.viewModel.badgeBorder)
            }
            .store(in: &cancellables)
        self.viewModel.$badgeBorder
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
                self?.badgeLabel.textColor = textColor.uiColor
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
        if self.viewModel.isBadgeOutlined {
            self.setupScalables()
            self.reloadBorderWidth()
        } else {
            self.layer.borderWidth = 0
        }
    }

    private func reloadColors() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        badgeLabel.textColor = self.viewModel.textColor.uiColor
        self.layer.borderColor = self.viewModel.badgeBorder.color.uiColor.cgColor
    }

    private func reloadBadgeFontIfNeeded() {
        guard !self.viewModel.isBadgeEmpty else {
            return
        }
        self.badgeLabel.font = self.viewModel.textFont.uiFont
    }

    private func reloadUISize() {
        if self.viewModel.isBadgeEmpty {
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

// MARK: - Badge Update Functions
public extension BadgeUIView {
    func setBadgeType(_ badgeType: BadgeIntentType) {
        self.viewModel.badgeType = badgeType
    }

    func setBadgeOutlineEnabled(_ isOutlined: Bool) {
        self.viewModel.isBadgeOutlined = isOutlined
    }

    func setBadgeValue(_ value: Int?) {
        self.viewModel.value = value
    }

    func setBadgeFormat(_ format: BadgeFormat) {
        self.viewModel.badgeFormat = format
    }

    func setBadgeSize(_ badgeSize: BadgeSize) {
        self.viewModel.badgeSize = badgeSize
    }

    func setBadgeTheme(_ theme: Theme) {
        self.viewModel.theme = theme
    }
}
