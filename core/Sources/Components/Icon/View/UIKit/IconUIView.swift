//
//  IconUIView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkTheming

public final class IconUIView: UIView {

    // MARK: - Public properties

    /// UIImage of the icon.
    public var icon: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }

    /// Used theme for the icon.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// Intent of icon.
    public var intent: IconIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.set(intent: newValue)
        }
    }

    /// Size of icon.
    public var size: IconSize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.set(size: newValue)
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: self.width, height: self.height)
    }

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var height: CGFloat = .zero
    @ScaledUIMetric private var width: CGFloat = .zero

    private let viewModel: IconViewModel

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.isAccessibilityElement = false
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)

        return imageView
    }()

    // MARK: - Initializers

    public init(
        iconImage: UIImage?,
        theme: Theme,
        intent: IconIntent,
        size: IconSize
    ) {
        self.viewModel = IconViewModel(theme: theme, intent: intent, size: size)

        super.init(frame: .zero)

        self.icon = iconImage
        self.setupView()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private funcs

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.accessibilityIdentifier = IconAccessibilityIdentifier.view

        self.addSubview(imageView)
        self.imageView.tintColor = self.viewModel.color.uiColor
        self.imageView.layoutMargins = UIEdgeInsets(vertical: .zero, horizontal: .zero)

        self.heightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: self.height)
        self.widthConstraint = self.imageView.widthAnchor.constraint(equalToConstant: self.width)
        self.heightConstraint?.isActive = true
        self.widthConstraint?.isActive = true

        let anchorConstraint = [
            self.imageView.topAnchor.constraint(equalTo: topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(anchorConstraint)
    }

    private func setupSubscriptions() {
        self.viewModel.$color.subscribe(in: &self.cancellables) { [weak self] color in
            self?.updateIconColor(color)
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            self?.height = size.value
            self?._height.update(traitCollection: self?.traitCollection)

            self?.width = size.value
            self?._width.update(traitCollection: self?.traitCollection)

            self?.updateIconSize()
            self?.invalidateIntrinsicContentSize()
        }
    }

    private func updateIconColor(_ color: any ColorToken) {
        self.imageView.tintColor = color.uiColor
    }

    private func updateIconSize() {
        if self.heightConstraint?.constant != self.height {
            self.heightConstraint?.constant = self.height
            self.updateConstraintsIfNeeded()
        }

        if self.widthConstraint?.constant != self.width {
            self.widthConstraint?.constant = self.width
            self.updateConstraintsIfNeeded()
        }
    }

    // MARK: - Trait collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.invalidateIntrinsicContentSize()
        self._height.update(traitCollection: traitCollection)
        self._width.update(traitCollection: traitCollection)
        self.updateIconSize()
    }

}
