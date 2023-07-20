//
//  IconUIView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

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

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    private var iconHeightAnchor: NSLayoutConstraint?
    private var iconWidthAnchor: NSLayoutConstraint?

    private let viewModel: IconViewModel

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        self.accessibilityIdentifier = IconAccessibilityIdentifier.text

        self.addSubview(imageView)
        self.imageView.tintColor = viewModel.color.foreground.uiColor
        self.imageView.layoutMargins = UIEdgeInsets(vertical: .zero, horizontal: .zero)

        self.iconHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: size.value)
        self.iconWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: size.value)
        self.iconHeightAnchor?.isActive = true
        self.iconWidthAnchor?.isActive = true

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
            self?.setIconColor(color)
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            self?.setIconSize(size)
        }
    }

    private func setIconColor(_ iconColor: IconColor) {
        self.imageView.tintColor = iconColor.foreground.uiColor
    }

    private func setIconSize(_ iconSize: IconSize) {
        self.iconHeightAnchor?.isActive = false
        self.iconWidthAnchor?.isActive = false

        self.iconHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: iconSize.value)
        self.iconWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: iconSize.value)

        self.iconHeightAnchor?.isActive = true
        self.iconWidthAnchor?.isActive = true
    }

}
