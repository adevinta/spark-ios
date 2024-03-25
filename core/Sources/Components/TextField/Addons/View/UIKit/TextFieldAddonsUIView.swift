//
//  TextFieldAddonsUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine

public final class TextFieldAddonsUIView: UIControl {

    @ScaledUIMetric private var scaleFactor: CGFloat = 1.0

    public let textField: TextFieldUIView
    private(set) public var leftAddon: UIView?
    private(set) public var rightAddon: UIView?

    public var leftAddonHasPadding: Bool = false
    public var rightAddonHasPadding: Bool = false

    private var leftAddonContainer = UIView()
    private var leftSeparatorView = UIView()
    private var leftSeparatorWidthConstraint = NSLayoutConstraint()
    private var rightAddonContainer = UIView()
    private var rightSeparatorView = UIView()
    private var rightSeparatorWidthConstraint = NSLayoutConstraint()

    private let viewModel: TextFieldAddonsViewModel
    private var cancellables = Set<AnyCancellable>()

    private var leadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var trailingConstraint: NSLayoutConstraint = NSLayoutConstraint()

    private var separatorWidth: CGFloat {
        return self.viewModel.borderWidth * self.scaleFactor
    }

    private lazy var stackView = UIStackView(arrangedSubviews: [
        self.leftAddonContainer,
        self.textField,
        self.rightAddonContainer
    ])

    public override var isEnabled: Bool {
        didSet {
            self.textField.isEnabled = self.isEnabled
        }
    }

    public override var isUserInteractionEnabled: Bool {
        didSet {
            self.textField.isUserInteractionEnabled = self.isUserInteractionEnabled
        }
    }

    public init(
        theme: Theme,
        intent: TextFieldIntent,
        successImage: UIImage,
        alertImage: UIImage,
        errorImage: UIImage) {
        let viewModel = TextFieldAddonsViewModel(
            theme: theme,
            intent: intent,
            successImage: .left(successImage),
            alertImage: .left(alertImage),
            errorImage: .left(errorImage))
        self.viewModel = viewModel
        self.textField = TextFieldUIView(viewModel: viewModel.textFieldViewModel)
        self.leftAddon = nil
        self.rightAddon = nil
        super.init(frame: .init(origin: .zero, size: .init(width: 200, height: 44)))
        self.textField.backgroundColor = ColorTokenDefault.clear.uiColor
        self.setupViews()
        self.subscribeToViewModel()
        self.textField.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.clipsToBounds = true
        self.addSubview(self.stackView)

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        NSLayoutConstraint.activate([
            self.leadingConstraint,
            self.trailingConstraint,
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.setupSeparators()
    }

    private func setupSeparators() {
        self.leftAddonContainer.addSubview(self.leftSeparatorView)
        self.leftSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        self.leftSeparatorWidthConstraint = self.leftSeparatorView.widthAnchor.constraint(equalToConstant: self.separatorWidth)

        self.rightAddonContainer.addSubview(self.rightSeparatorView)
        self.rightSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        self.rightSeparatorWidthConstraint = self.rightSeparatorView.widthAnchor.constraint(equalToConstant: self.separatorWidth)

        NSLayoutConstraint.activate([
            self.leftSeparatorWidthConstraint,
            self.leftSeparatorView.topAnchor.constraint(equalTo: self.leftAddonContainer.topAnchor),
            self.leftSeparatorView.bottomAnchor.constraint(equalTo: self.leftAddonContainer.bottomAnchor),
            self.leftSeparatorView.trailingAnchor.constraint(equalTo: self.leftAddonContainer.trailingAnchor),

            self.rightSeparatorWidthConstraint,
            self.rightSeparatorView.topAnchor.constraint(equalTo: self.rightAddonContainer.topAnchor),
            self.rightSeparatorView.bottomAnchor.constraint(equalTo: self.rightAddonContainer.bottomAnchor),
            self.rightSeparatorView.leadingAnchor.constraint(equalTo: self.rightAddonContainer.leadingAnchor)
        ])
    }

    private func subscribeToViewModel() {
        self.viewModel.backgroundColorSubject.subscribe(in: &self.cancellables) { [weak self] backgroundColor in
            guard let self else { return }
            self.backgroundColor = backgroundColor.uiColor
            self.textField.backgroundColor = .clear
        }

        self.viewModel.textFieldViewModel.borderColorSubject.subscribe(in: &self.cancellables) { [weak self] borderColor in
            guard let self else { return }
            self.setBorderColor(from: borderColor)
            self.leftSeparatorView.backgroundColor = borderColor.uiColor
            self.rightSeparatorView.backgroundColor = borderColor.uiColor
        }

        self.viewModel.borderWidthSubject.subscribe(in: &self.cancellables) { [weak self] borderWidth in
            guard let self else { return }
            let width = borderWidth * self.scaleFactor
            self.setBorderWidth(width)
            self.leftSeparatorWidthConstraint.constant = width
            self.rightSeparatorWidthConstraint.constant = width
        }

        self.viewModel.borderRadiusSubject.subscribe(in: &self.cancellables) { [weak self] borderRadius in
            guard let self else { return }
            self.setCornerRadius(borderRadius)
        }

        self.viewModel.leftSpacingSubject.subscribe(in: &self.cancellables) { [weak self] leftSpacing in
            guard let self else { return }
            self.leadingConstraint.constant = self.leftAddonContainer.isHidden ? leftSpacing : .zero
            self.setNeedsLayout()
        }

        self.viewModel.rightSpacingSubject.subscribe(in: &self.cancellables) { [weak self] rightSpacing in
            guard let self else { return }
            self.trailingConstraint.constant = self.rightAddonContainer.isHidden ? -rightSpacing : .zero
            self.setNeedsLayout()
        }

        self.viewModel.contentSpacingSubject.subscribe(in: &self.cancellables) { [weak self] contentSpacing in
            guard let self else { return }
            self.stackView.spacing = contentSpacing
            self.setNeedsLayout()
        }

        self.viewModel.dimSubject.subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.alpha = dim
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.setBorderColor(from: self.viewModel.textFieldViewModel.borderColor)
        }

        guard previousTraitCollection?.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory else { return }

        self._scaleFactor.update(traitCollection: self.traitCollection)
        let width = self.viewModel.borderWidth * self.scaleFactor
        self.setBorderWidth(width)
        self.leftSeparatorWidthConstraint.constant = width
        self.rightSeparatorWidthConstraint.constant = width
        self.invalidateIntrinsicContentSize()
    }

    public func setLeftAddon(_ leftAddon: UIView?, withPadding: Bool = false) {
        if let oldValue = self.leftAddon, oldValue.isDescendant(of: self.leftAddonContainer) {
            oldValue.removeFromSuperview()
        }
        if let leftAddon {
            self.leftAddonContainer.addSubview(leftAddon)
            leftAddon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leftAddon.trailingAnchor.constraint(lessThanOrEqualTo: self.leftSeparatorView.leadingAnchor, constant: withPadding ? -self.viewModel.leftSpacing : 0),
                leftAddon.centerXAnchor.constraint(equalTo: self.leftAddonContainer.centerXAnchor, constant: -self.separatorWidth / 2.0),
                leftAddon.centerYAnchor.constraint(equalTo: self.leftAddonContainer.centerYAnchor)
            ])
        }
        self.leftAddon = leftAddon
        self.leftAddonContainer.isHidden = self.leftAddon == nil
        self.leadingConstraint.constant = self.leftAddonContainer.isHidden ? self.viewModel.leftSpacing : .zero
    }

    public func setRightAddon(_ rightAddon: UIView? = nil, withPadding: Bool = false) {
        if let oldValue = self.rightAddon, oldValue.isDescendant(of: self.rightAddonContainer) {
            oldValue.removeFromSuperview()
        }
        if let rightAddon {
            self.rightAddonContainer.addSubview(rightAddon)
            rightAddon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rightAddon.leadingAnchor.constraint(greaterThanOrEqualTo: self.rightSeparatorView.trailingAnchor, constant: withPadding ? self.viewModel.rightSpacing : 0),
                rightAddon.centerXAnchor.constraint(equalTo: self.rightAddonContainer.centerXAnchor, constant: self.separatorWidth / 2.0),
                rightAddon.centerYAnchor.constraint(equalTo: self.rightAddonContainer.centerYAnchor)
            ])
        }
        self.rightAddon = rightAddon
        self.rightAddonContainer.isHidden = self.rightAddon == nil
        self.trailingConstraint.constant = self.rightAddonContainer.isHidden ? -self.viewModel.rightSpacing : .zero
    }
}
