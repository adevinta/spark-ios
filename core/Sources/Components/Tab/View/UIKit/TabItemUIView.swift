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

    private var label: UILabel?
    private var image: UIImageView?
    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var paddingVertical: CGFloat
    @ScaledUIMetric private var paddingHorizontal: CGFloat
    @ScaledUIMetric private var borderLineHeight: CGFloat
    private var borderLineHeightConstraint: NSLayoutConstraint?

    private var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.paddingVertical,
                            left: self.paddingHorizontal,
                            bottom: self.paddingVertical,
                            right: self.paddingHorizontal)
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

    private var border: UIView {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
    }

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return button
    }()

    @ObservedObject private var viewModel: TabItemViewModel

    public var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public convenience init(theme: Theme,
                            intent: TabIntent = .main,
                            label: String) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent)
        viewModel.text = label
        self.init(viewModel: viewModel)
    }

    public convenience init(theme: Theme,
                            intent: TabIntent = .main,
                            image: UIImage) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent)
        viewModel.icon = image
        self.init(viewModel: viewModel)
    }

    init(viewModel: TabItemViewModel) {
        self.viewModel = viewModel
        self._spacing = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.content)
        self._paddingVertical = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.verticalEdge)
        self._paddingHorizontal = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.horizontalEdge)
        self._borderLineHeight = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.separatorLineHeight)

        super.init(frame: .zero)

        self.setupView()
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

        self.borderLineHeightConstraint?.constant = borderLineHeight
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
            // TODO update spacings etc here
        }
    }

    private func addOrRemoveIcon(_ icon: UIImage?) {
        if let icon = icon {
            if let image = self.image {
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
            } else {
                let image = UIImageView.standard
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                self.stackView.insertArrangedSubview(image, at: 0)
                self.image = image
            }
        } else if let image = self.image {
            self.stackView.removeArrangedSubview(image)
            self.image = nil
        }
    }

    private func addOrRemoveLabel(_ text: String?) {
        if let text = text {
            if let label = self.label {
                label.text = text
                label.textColor = self.viewModel.tabStateAttributes.colors.label.uiColor
            } else {
                let label = UILabel.standard
                label.text = text
                label.textColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                let labelIndex = self.image == nil ? 0 : 1
                self.stackView.insertArrangedSubview(label, at: labelIndex)
                self.label = label
            }
        } else if let label = self.label {
            self.stackView.removeArrangedSubview(label)
            self.label = nil
        }
    }

    private func addOrRemoveBadge(_ badge: BadgeUIView?) {
        if let currentBadge = self.badge {
            self.stackView.removeArrangedSubview(currentBadge)
        }

        if let newBadge = badge {
            let index = [self.image, self.label].compacted().count
            self.stackView.insertArrangedSubview(newBadge, at: index)
            self.badge = newBadge
        }
    }

    private func setupView() {
        self.stackView.spacing = self.spacing
        self.stackView.layoutMargins = self.edgeInsets
        self.stackView.isLayoutMarginsRelativeArrangement = true

        self.addSubview(self.stackView)

        self.button.frame = self.bounds
        self.addSubview(self.button)

        self.border.backgroundColor = self.viewModel.tabStateAttributes.colors.line.uiColor
        self.addSubview(self.border)

        self.addSubview(border)
    }

    private func setupConstraints() {
        NSLayoutConstraint.stickEdges(from: self, to: self.stackView)

        let borderLineHeightConstraint = border.heightAnchor.constraint(equalToConstant: self.borderLineHeight)

        self.borderLineHeightConstraint = borderLineHeightConstraint
        NSLayoutConstraint.activate([
            borderLineHeightConstraint,
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

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
