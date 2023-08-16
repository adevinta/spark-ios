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

/// A single component of the tabs view.
/// The standard tab item consists of an icon, label and a badge.
/// The badge is not restricted in type and any UIView may be accepted. .
/// The label and icon are publicly accessible, so the standard label may be replaced with an attributed string.
/// The layout of the tab item is orgianized with a stack view. This stack view is publicly accessible, and further views may be added to it. The developer needs to pay caution, not to break constraints.
public final class TabItemUIView: UIControl {

    // MARK: - Private variables
    private var subscriptions = Set<AnyCancellable>()
    private var bottomLineHeightConstraint: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    public var action: UIAction?

    private var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.paddingVertical,
                            left: self.paddingHorizontal,
                            bottom: self.paddingVertical,
                            right: self.paddingHorizontal)
    }

    private var bottomLine: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return border
    }()

    private var iconHeight: CGFloat {
        return self.viewModel.tabStateAttributes.font.uiFont.pointSize
    }

    // MARK: - Scaled metrics
    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var paddingVertical: CGFloat
    @ScaledUIMetric private var paddingHorizontal: CGFloat
    @ScaledUIMetric private var borderLineHeight: CGFloat
    @ScaledUIMetric var height: CGFloat

    @ObservedObject var viewModel: TabItemViewModel

    // MARK: - Public variables
    /// The label shown in the tab item.
    ///
    /// The attributes may be changed as required, e.g. using an attributed string instead of a standard string.
    public private(set) var label: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.isUserInteractionEnabled = false
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh,
                                                      for: .horizontal)
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        return label
    }()

    /// The image view containing the icon.
    ///
    /// The attributes of the icon can be changed directly or replaced by changing the imageView.
    public private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        imageView.isUserInteractionEnabled = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true

        imageView.setContentCompressionResistancePriority(.required,
                                                      for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        return imageView
    }()

    /// The badge which is rendered to the right of the label.
    ///
    /// The badge will typically be used for rendering a BadgeUIView, but it is not restricted to this type. Any type of view may be added as a badge.
    /// It is possible to add further views to the tab, by directly accessing the stackView.
    public var badge: UIView? {
        didSet {
            guard badge != oldValue else { return }

            if let currentBadge = oldValue {
                self.stackView.detachArrangedSubview(currentBadge)
            }

            if let newBadge = self.badge {
                newBadge.isUserInteractionEnabled = false

                self.stackView.addArrangedSubview(newBadge)
            }
            
            self.invalidateIntrinsicContentSize()
        }
    }

    /// The stack view containing the single items of the tab.
    ///
    /// The stack view is publicly accessible, so that the contents of the tab may be changed to special needs.
    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    /// The current theme of the view.
    ///
    /// By changing the theme, the colors and spacings of the tab item will change according to the new theme.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    /// The current intent of the view.
    ///
    /// By chaning the intent, the colors of the selected tab item will change.
    public var intent: TabIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    /// The icon of the component.
    ///
    /// The icon is the leftmost component of the tab item.
    /// If the icon is nil, no label will be shown on the tab item. To change the attributes of the icon, the image view is publicly accessible.
    public var icon: UIImage? {
        get {
            return self.viewModel.icon
        }
        set {
            guard self.viewModel.icon != newValue else { return }
            self.viewModel.icon = newValue
        }
    }

    /// The standard title of the tab item.
    ///
    /// The title is shown to the right of the icon.
    /// If the title is nil, no label will be added to the tab item. To change the attributes of the text, you can directly access the label of this component.
    public var title: String? {
        get {
            return self.viewModel.title
        }
        set {
            guard self.viewModel.title != newValue else { return }
            self.viewModel.title = newValue
        }
    }

    /// The current tab size
    public var tabSize: TabSize {
        get {
            return self.viewModel.tabSize
        }
        set {
            self.viewModel.tabSize = newValue
        }
    }

    /// A Boolean value indicating whether the control is in the selected state.
    ///
    /// Set the value of this property to true to select it or false to deselect it. The colors and design of the tab item change whether it is selected or not.
    /// The default value of this property is false for a newly created control.
    public override var isSelected: Bool {
        get {
            return self.backingIsSelected
        }
        set {
            guard newValue != self.backingIsSelected else { return }
            if newValue {
                self.sendActions(for: .otherSegmentSelected)
            }
            self.backingIsSelected = newValue
        }
    }

    // An internal property used for setting the isSelected tab without triggering an action
    internal var backingIsSelected: Bool {
        get {
            return self.viewModel.isSelected
        }
        set {
            guard newValue != self.viewModel.isSelected else { return }
            self.viewModel.isSelected = newValue
        }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    ///
    /// Set the value of this property to true to enable the control or false to disable it. An enabled control is capable of responding to user interactions, whereas a disabled control ignores touch events and may draw itself differently.
    /// The default value of this property is true for a newly created control. You can set a control’s initial enabled state in your storyboard file.
    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            guard newValue != self.viewModel.isEnabled else { return }
            self.viewModel.isEnabled = newValue
        }
    }

    /// A Boolean value indicating that the tab has no content.
    public var isEmpty: Bool {
        return !self.stackView.arrangedSubviews.contains(where: {$0.isHidden == false})
    }

    public override var intrinsicContentSize: CGSize {
        var itemsWidth: CGFloat = 0

        if self.label.isNotHidden {
            itemsWidth += self.label.intrinsicContentSize.width
        }

        if self.imageView.isNotHidden {
            itemsWidth += self.iconHeight
        }

        if let badge = self.badge, self.isNotHidden {
            itemsWidth += badge.intrinsicContentSize.width == UIView.noIntrinsicMetric ? self.height : badge.intrinsicContentSize.width
        }

        let numberOfSpacings = max(self.stackView.arrangedSubviews.filter(\.isNotHidden).count - 1, 0)
        let spacingsWidth = CGFloat(numberOfSpacings) * self.spacing

        let totalWidth = self.paddingHorizontal + (itemsWidth + spacingsWidth) + self.paddingHorizontal

        return CGSize(width: totalWidth, height: self.height)
    }

    // MARK: - Initializers
    /// Create a tab item view.
    ///
    /// - Parameters:
    /// theme: the current theme, which will determine the colors and spacings
    /// intent: the intent of the tab item
    /// text: optional string, the label if the tab item if set
    /// icon: optional image of the tab item
    public convenience init(theme: Theme,
                            intent: TabIntent = .main,
                            tabSize: TabSize = .md,
                            title: String? = nil,
                            icon: UIImage? = nil) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent, tabSize: tabSize)
        viewModel.title = title
        viewModel.icon = icon
        self.init(viewModel: viewModel)
    }

    init(viewModel: TabItemViewModel) {
        self.viewModel = viewModel

        self._spacing = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.content)
        self._paddingVertical = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.verticalEdge)
        self._paddingHorizontal = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.spacings.horizontalEdge)
        self._borderLineHeight = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.heights.separatorLineHeight)
        self._height = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.heights.itemHeight)

        super.init(frame: .zero)

        self.setupView()
        self.setupConstraints()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard self.traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else {
            return
        }
        self._spacing.update(traitCollection: self.traitCollection)
        self._paddingVertical.update(traitCollection: self.traitCollection)
        self._paddingHorizontal.update(traitCollection: self.traitCollection)
        self._borderLineHeight.update(traitCollection: self.traitCollection)
        self._height.update(traitCollection: self.traitCollection)

        self.invalidateIntrinsicContentSize()

        self.updateLayoutConstraints()
    }

    // MARK: - Control functions
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.viewModel.isPressed = true
        self.sendActions(for: .touchDown)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.pressFinised()
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.viewModel.isPressed = false
        self.sendActions(for: .touchCancel)
    }

    // MARK: - Private functions
    private func pressFinised() {
        self.viewModel.isPressed = false
        self.sendActions(for: .touchUpInside)
        if let action = self.action {
            self.sendAction(action)
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$content.subscribe(in: &self.subscriptions) { [weak self] itemContent in
            guard let self else { return }
            self.addOrRemoveIcon(itemContent.icon)
            self.addOrRemoveTitle(itemContent.title)
            self.invalidateIntrinsicContentSize()
        }

        self.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { [weak self] attributes in
            guard let self else { return }
            self.setupColors(attributes: attributes)
            self.updateSizes(attributes: attributes)
            self.updateLayoutConstraints()
            self.invalidateIntrinsicContentSize()
        }
    }

    private func setupView() {
        self.accessibilityIdentifier = TabAccessibilityIdentifier.tabItem
        self.stackView.spacing = self.spacing
        self.stackView.layoutMargins = self.edgeInsets

        self.addSubviewSizedEqually(self.stackView)

        self.setupColors(attributes: self.viewModel.tabStateAttributes)

        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.label)

        self.addSubview(self.bottomLine)
        self.bringSubviewToFront(self.bottomLine)

        if self.viewModel.title == nil {
            self.label.isHidden = true
        }
        if self.viewModel.icon == nil {
            self.imageView.isHidden = true
        }
    }

    private func setupColors(attributes: TabStateAttributes) {
        self.label.font = attributes.font.uiFont
        self.label.textColor = attributes.colors.label.uiColor

        self.imageView.tintColor = attributes.colors.label.uiColor

        self.bottomLine.backgroundColor = attributes.colors.line.uiColor
        self.stackView.backgroundColor = attributes.colors.background.uiColor

        let opacity = Float(attributes.colors.opacity)
        self.bottomLine.layer.opacity = opacity
        self.stackView.layer.opacity = opacity
    }

    private func updateSizes(attributes: TabStateAttributes) {
        self._spacing = ScaledUIMetric(wrappedValue: attributes.spacings.content)
        self._paddingVertical = ScaledUIMetric(wrappedValue: attributes.spacings.verticalEdge)
        self._paddingHorizontal = ScaledUIMetric(wrappedValue: attributes.spacings.horizontalEdge)
        self._borderLineHeight = ScaledUIMetric(wrappedValue: attributes.heights.separatorLineHeight)
        self._height = ScaledUIMetric(wrappedValue: attributes.heights.itemHeight)
    }

    private func updateLayoutConstraints() {

        let iconHeight = self.viewModel.tabStateAttributes.font.uiFont.pointSize
        self.imageViewHeightConstraint?.constant = iconHeight

        self.bottomLineHeightConstraint?.constant = self.borderLineHeight
        self.heightConstraint?.constant = self.height

        self.stackView.spacing = self.spacing
        self.stackView.layoutMargins = self.edgeInsets
    }

    private func setupConstraints() {
        let iconHeight = self.viewModel.tabStateAttributes.font.uiFont.pointSize
        let lineHeightConstraint = self.bottomLine.heightAnchor.constraint(equalToConstant: self.borderLineHeight)
        let imageHeightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: iconHeight)
        let heightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.height)

        NSLayoutConstraint.activate([
            lineHeightConstraint,
            imageHeightConstraint,
            heightConstraint,
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
            self.bottomLine.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            self.bottomLine.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            self.bottomLine.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor)
        ])
        self.bottomLineHeightConstraint = lineHeightConstraint
        self.imageViewHeightConstraint = imageHeightConstraint
        self.heightConstraint = heightConstraint
    }

    private func addOrRemoveIcon(_ icon: UIImage?) {
        guard icon != self.imageView.image else { return }
        if let icon = icon {
            self.imageView.image = icon
            self.imageView.tintColor = self.viewModel.tabStateAttributes.colors.icon.uiColor
            self.imageView.isHidden = false
        } else {
            self.imageView.isHidden = true
        }
    }

    private func addOrRemoveTitle(_ text: String?) {
        guard text != self.label.text else { return }
        if let text = text {
            self.label.text = text
            self.label.isHidden = false
        } else {
            self.label.isHidden = true
        }
    }
}

public extension UIControl.Event {
    static let otherSegmentSelected = UIControl.Event(rawValue: 0b0010 << 24)
}
