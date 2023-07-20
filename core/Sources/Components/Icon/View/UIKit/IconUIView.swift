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
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    /// Used theme for the icon.
    public var theme: Theme {
        get {
            return viewModel.theme
        }
        set {
            viewModel.set(theme: newValue)
        }
    }

    /// Intent of icon.
    public var intent: IconIntent {
        get {
            return viewModel.intent
        }
        set {
            viewModel.set(intent: newValue)
        }
    }

    /// Size of icon.
    public var size: IconSize {
        get {
            return viewModel.size
        }
        set {
            viewModel.set(size: newValue)
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
        viewModel = IconViewModel(theme: theme, intent: intent, size: size)

        super.init(frame: .zero)

        icon = iconImage
        setupView()
        setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private funcs

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        accessibilityIdentifier = IconAccessibilityIdentifier.text

        addSubview(imageView)
        imageView.tintColor = viewModel.color.foreground.uiColor
        imageView.layoutMargins = UIEdgeInsets(vertical: .zero, horizontal: .zero)

        iconHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: size.value)
        iconWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: size.value)
        iconHeightAnchor?.isActive = true
        iconWidthAnchor?.isActive = true

        let anchorConstraint = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(anchorConstraint)
    }

    private func setupSubscriptions() {
        viewModel.$color
            .receive(on: DispatchQueue.main)
            .sink { [weak self] color in
                self?.setIconColor(color)
            }
            .store(in: &cancellables)

        viewModel.$size
            .receive(on: DispatchQueue.main)
            .sink { [weak self] size in
                self?.setIconSize(size)
            }
            .store(in: &cancellables)
    }

    private func setIconColor(_ iconColor: IconColor) {
        imageView.tintColor = iconColor.foreground.uiColor
    }

    private func setIconSize(_ iconSize: IconSize) {
        iconHeightAnchor?.isActive = false
        iconWidthAnchor?.isActive = false

        iconHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: iconSize.value)
        iconWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: iconSize.value)

        iconHeightAnchor?.isActive = true
        iconWidthAnchor?.isActive = true
    }

}
