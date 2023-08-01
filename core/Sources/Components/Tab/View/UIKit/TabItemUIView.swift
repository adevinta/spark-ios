//
//  TabItemUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 31.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

public final class TabItemUIView: UIView {
    private var subscriptions = Set<AnyCancellable>()

    private var labelInStackView: UILabel?
    private var imageInStackView: UIImageView?
    private var badgeInStackView: BadgeUIView?

    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var paddingVertical: CGFloat
    @ScaledUIMetric private var paddingHorizontal: CGFloat
    @ScaledUIMetric private var borderLineHeight: CGFloat
    @ScaledUIMetric private var height: CGFloat

    private var bottomLineHeightConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.paddingVertical,
                            left: self.paddingHorizontal,
                            bottom: self.paddingVertical,
                            right: self.paddingHorizontal)
    }

    public var label: UILabel? {
        get {
            return self.labelInStackView
        }
        set {
            if let labelInStackView = self.labelInStackView {
                labelInStackView.removeFromSuperview()
                self.stackView.removeArrangedSubview(labelInStackView)
            }
            if let newLabel = newValue {
                let index = self.imageInStackView == nil ? 0 : 1
                self.stackView.insertArrangedSubview(newLabel, at: index)
            }
            self.labelInStackView = newValue
        }
    }

    public var imageView: UIImageView? {
        get {
            return self.imageInStackView
        }
        set {
            if let imageInStackView = self.imageInStackView {
                imageInStackView.removeFromSuperview()
                self.stackView.removeArrangedSubview(imageInStackView)
            }
            self.imageInStackView = newValue
            if let newImage = newValue {
                self.stackView.insertArrangedSubview(newImage, at: 0)
            }
        }
    }

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    public var intent: TabIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var icon: UIImage? {
        get {
            return self.viewModel.icon
        }
        set {
            self.viewModel.icon = newValue
        }
    }
   
    public var text: String? {
        get {
            return self.viewModel.text
        }
        set {
            self.viewModel.text = newValue
        }
    }

    public var badge: BadgeUIView? {
        get {
            return self.viewModel.badge
        }
        set {
            self.viewModel.badge = newValue
        }
    }

    public var isSelected: Bool {
        get {
            return self.viewModel.isSelected
        }
        set {
            self.viewModel.isSelected = newValue
        }
    }

    public var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.isEnabled = newValue
        }
    }

    private var bottomLine: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return border
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return button
    }()

    @ObservedObject private var viewModel: TabItemViewModel

    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    public convenience init(theme: Theme,
                            intent: TabIntent = .main,
                            label: String? = nil,
                            icon: UIImage? = nil) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent)
        viewModel.text = label
        viewModel.icon = icon
        self.init(viewModel: viewModel)
    }

    init(viewModel: TabItemViewModel) {
        self.viewModel = viewModel
        self._spacing = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.content)
        self._paddingVertical = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.verticalEdge)
        self._paddingHorizontal = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.horizontalEdge)
        self._borderLineHeight = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.separatorLineHeight)
        self._height = ScaledUIMetric(wrappedValue: viewModel.height)

        super.init(frame: .zero)

        self.setupView()
        self.setupConstraints()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)
        self._paddingVertical.update(traitCollection: traitCollection)
        self._paddingHorizontal.update(traitCollection: traitCollection)
        self._borderLineHeight.update(traitCollection: traitCollection)
        self._height.update(traitCollection: traitCollection)

        self.bottomLineHeightConstraint?.constant = self.borderLineHeight
        self.heightConstraint?.constant = self.height
        self.stackView.layoutMargins = self.edgeInsets
    }

    private func setupSubscriptions() {
        self.viewModel.$content.subscribe(in: &self.subscriptions) { [weak self] itemContent in
            guard let self else { return }
            self.addOrRemoveIcon(itemContent.icon)
            self.addOrRemoveLabel(itemContent.text)
            self.addOrRemoveBadge(itemContent.badge)
        }

        self.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { [weak self] attributes in
            guard let self else { return }

            self.labelInStackView?.font = attributes.font.uiFont
            self.labelInStackView?.textColor = attributes.colors.label.uiColor
            self.imageInStackView?.tintColor = attributes.colors.label.uiColor
            self.bottomLine.backgroundColor = attributes.colors.line.uiColor
        }

    }

    private func addOrRemoveIcon(_ icon: UIImage?) {
        if let icon = icon {
            if let image = self.imageInStackView {
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
            } else {
                let image = UIImageView.standard
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                self.stackView.insertArrangedSubview(image, at: 0)
                self.imageInStackView = image
            }
        } else if let image = self.imageInStackView {
            image.removeFromSuperview()
            self.stackView.removeArrangedSubview(image)
            self.imageInStackView = nil
        }
    }

    private func addOrRemoveLabel(_ text: String?) {
        if let text = text {
            if let label = self.labelInStackView {
                label.text = text
                label.textColor = self.viewModel.tabStateAttributes.colors.label.uiColor
            } else {
                let label = UILabel.standard
                label.text = text
                label.textColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                let labelIndex = self.imageInStackView == nil ? 0 : 1
                self.stackView.insertArrangedSubview(label, at: labelIndex)
                self.labelInStackView = label
            }
        } else if let label = self.labelInStackView {
            label.removeFromSuperview()
            self.stackView.removeArrangedSubview(label)
            self.labelInStackView = nil
        }
    }

    private func addOrRemoveBadge(_ badge: BadgeUIView?) {
        guard badge != self.badgeInStackView else { return }

        if let currentBadge = self.badgeInStackView {
            currentBadge.removeFromSuperview()
            self.stackView.removeArrangedSubview(currentBadge)
        }

        if let newBadge = badge {
            let index = [self.imageInStackView, self.labelInStackView].compacted().count
            self.stackView.insertArrangedSubview(newBadge, at: index)
        }

        self.badgeInStackView = badge
    }

    private func setupView() {

        self.translatesAutoresizingMaskIntoConstraints = false

        self.stackView.spacing = self.spacing
        self.stackView.layoutMargins = self.edgeInsets

        self.addSubview(self.stackView)

        self.button.frame = self.bounds
        self.addSubview(self.button)

        let colors = self.viewModel.tabStateAttributes.colors
        let font = self.viewModel.tabStateAttributes.font

        self.bottomLine.backgroundColor = colors.line.uiColor

        self.addSubview(self.bottomLine)
        self.bringSubviewToFront(self.bottomLine)

        self.labelInStackView?.font = font.uiFont
        self.labelInStackView?.textColor = colors.label.uiColor
        self.imageInStackView?.tintColor = colors.label.uiColor
        self.bottomLine.backgroundColor = colors.line.uiColor
    }

    private func setupConstraints() {
        NSLayoutConstraint.stickEdges(from: self, to: self.stackView)

        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: self.height)

        let lineHeightConstraint = self.bottomLine.heightAnchor.constraint(equalToConstant: self.borderLineHeight)
        heightConstraint.priority = .required

        NSLayoutConstraint.activate([
            heightConstraint,
            lineHeightConstraint,
            self.bottomLine.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            self.bottomLine.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            self.bottomLine.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor)
        ])
        self.heightConstraint = heightConstraint
        self.bottomLineHeightConstraint = lineHeightConstraint
    }
}

private extension UIView {
    func withStandardAttributes() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.isAccessibilityElement = false
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        return self
    }
}

private extension UIImageView {
    static var standard: UIImageView {
        return UIImageView().withStandardAttributes()
    }
}

private extension UILabel {
    static var standard: UILabel {
        return UILabel().withStandardAttributes()
    }
}
