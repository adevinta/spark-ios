//
//  BadgeUIView.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// This is the UIKit version for the ``BadgeView``
public class BadgeUIView: UILabel {

    private var viewModel: BadgeViewModel

    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var verticalSpacing: CGFloat = 0
    @ScaledUIMetric private var emptyBadgeSize: CGFloat = 0

    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?

    public init(viewModel: BadgeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupBadge()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    private func setupBadge() {
        setupBadgeText()
        setupAppearance()
        setupLayouts()
    }

    private func setupBadgeText() {
        self.text = self.viewModel.text
        self.textColor = self.viewModel.textColor.uiColor
        self.font = self.viewModel.textFont.uiFont
        self.adjustsFontForContentSizeCategory = true
        self.textAlignment = .center
    }

    private func setupAppearance() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = self.viewModel.badgeBorder.width
        self.layer.borderColor = self.viewModel.badgeBorder.color.uiColor.cgColor
        self.layer.cornerRadius = self.viewModel.badgeBorder.radius
        self.clipsToBounds = true
    }

    private func setupLayouts() {
        var estimatedSize = self.estimatedSize(for: self.viewModel.text)
        reloadUISize()
        if viewModel.text.isEmpty {
            estimatedSize = .init(width: self.emptyBadgeSize, height: self.emptyBadgeSize)
        } else {
            estimatedSize = .init(width: ceil(estimatedSize.width + self.horizontalSpacing), height: ceil(estimatedSize.height + self.verticalSpacing))
        }

        setupSizeConstraints(with: estimatedSize)

        self.layer.cornerRadius = estimatedSize.height / 2.0
    }

    private func estimatedSize(for text: String) -> CGSize {
        if self.viewModel.text.isEmpty {
            return BadgeConstants.emptySize
        } else {
            let size = CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let attributes = [NSAttributedString.Key.font: font]
            return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil).size
        }
    }

    private func setupSizeConstraints(with size: CGSize) {
        if let heightConstraint {
            heightConstraint.constant = size.height
        } else {
            self.heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
            self.heightConstraint?.isActive = true
        }
        if let widthConstraint {
            widthConstraint.constant = size.width
        } else {
            self.widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
            self.widthConstraint?.isActive = true
        }
    }

    private func reloadUISize() {
        if self.viewModel.text.isEmpty {
            self.emptyBadgeSize = BadgeConstants.emptySize.width
            self._emptyBadgeSize.update(traitCollection: self.traitCollection)
        } else {
            self.horizontalSpacing = self.viewModel.horizontalOffset
            self._horizontalSpacing.update(traitCollection: self.traitCollection)
            self.verticalSpacing = self.viewModel.verticalOffset
            self._verticalSpacing.update(traitCollection: self.traitCollection)
        }
    }

    private func reloadUIFromColors() {
        self.backgroundColor = self.viewModel.backgroundColor.uiColor
        self.textColor = self.viewModel.textColor.uiColor
        self.layer.borderColor = self.viewModel.badgeBorder.color.uiColor.cgColor
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.reloadUIFromColors()
        }

        self.setupBadgeText()
        self.reloadUISize()
        self.setupLayouts()
        self.layoutIfNeeded()
    }
}
