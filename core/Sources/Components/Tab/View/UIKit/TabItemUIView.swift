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
/// The badge is not restricted in type and any UIView may be accepted. It is to be noted, that the exptected view is not to be higher than 24px, otherwise constraints will be broken.
/// The label and icon are publicly accessible, so the standard label maye be replaced with an attributed string.
/// The layout of the tab item is orgianized with a stack view. This stack view is also publicly accessible, and further views may be added to it. Again here, the developer needs to pay caution, not to break constraints.
public final class TabItemUIView: UIControl {

    // MARK: - Private variables
    private var subscriptions = Set<AnyCancellable>()
    private var bottomLineHeightConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?

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

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = false
        return button
    }()

    // MARK: - Scaled metrics
    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var paddingVertical: CGFloat
    @ScaledUIMetric private var paddingHorizontal: CGFloat
    @ScaledUIMetric private var borderLineHeight: CGFloat
    @ScaledUIMetric private var iconHeight: CGFloat

    @ObservedObject private var viewModel: TabItemViewModel

    // MARK: - Public variables
    /// The label shown in the tab item.
    ///
    /// The attributes may be changed as required, e.g. using an attributed string instead of a standard string.
    public private(set) var label: UILabel? {
        didSet {
            if let labelInStackView = oldValue {
                labelInStackView.removeFromSuperview()
                self.stackView.removeArrangedSubview(labelInStackView)
            }
            if let newLabel = self.label {
                let index = self.imageView == nil ? 0 : 1
                self.stackView.insertArrangedSubview(newLabel, at: index)
            }
        }
    }

    /// The image view containing the icon.
    ///
    /// To attributes of the icon can be changed directly or replaced by changing the imageView.
    public private(set) var imageView: UIImageView? {
        didSet {
            if let imageInStackView = oldValue {
                imageInStackView.removeFromSuperview()
                self.stackView.removeArrangedSubview(imageInStackView)
            }
            if let newImage = self.imageView {
                self.stackView.insertArrangedSubview(newImage, at: 0)
                self.enableImageSizeConstraints()
            } else {
                self.disableImageViewSizeConstraints()
            }
        }
    }

    /// The badge which is rendered to the right of the label.
    ///
    /// The badge will typically be used for rendering a BadgeUIView, but it is not restricted to this type. Any type of view may be added as a badge. It is to be noted, that the view added should have a maximum height of 24px, othewise the constraints of the tab item will be broken.
    /// It is also possible to add further views to the tab, by directly accessing the stackView.
    public var badge: UIView? {
        didSet {
            guard badge != oldValue else { return }

            if let currentBadge = oldValue {
                currentBadge.removeFromSuperview()
                self.stackView.removeArrangedSubview(currentBadge)
            }

            if let newBadge = self.badge {
                let index = [self.imageView, self.label].compacted().count
                self.stackView.insertArrangedSubview(newBadge, at: index)
            }
        }
    }

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
            self.viewModel.icon = newValue
        }
    }

    /// The standard text of the tab item.
    ///
    /// The text is shown to the right of the icon.
    /// If the text is nil, no label will be added to the tab item. To change the attributes of the text, you can directly access the label of this component.
    public var text: String? {
        get {
            return self.viewModel.text
        }
        set {
            self.viewModel.text = newValue
        }
    }

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
            return self.viewModel.isSelected
        }
        set {
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
            self.viewModel.isEnabled = newValue
        }
    }

    /// The stack view containing the single items of the tab.
    ///
    /// The stack view is publicly accessible, so that the contents of the tab may be changed to special needs. It must be noted though, that the components added may not exceed the height of 24px, otherwise the constraints of the tab item will be broken.
    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - Initializers
    /// Create a tab item view.
    ///
    /// - Parameters:
    /// theme: the current theme, which will determine the colors and spacings
    /// intent: the intent of the tab item
    /// label: optional string, the label if the tab item if set
    /// icon: optional image of the tab item
    public convenience init(theme: Theme,
                            intent: TabIntent = .main,
                            tabSize: TabSize = .md,
                            label: String? = nil,
                            icon: UIImage? = nil) {
        let viewModel = TabItemViewModel(theme: theme, intent: intent, tabSize: tabSize)
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
        self._iconHeight = ScaledUIMetric(wrappedValue: viewModel.tabStateAttributes.font.uiFont.lineHeight)

        super.init(frame: .zero)

        self.setupView()
        self.setupConstraints()
        self.setupSubscriptions()
        self.setupButtonActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)
        self._paddingVertical.update(traitCollection: traitCollection)
        self._paddingHorizontal.update(traitCollection: traitCollection)
        self._borderLineHeight.update(traitCollection: traitCollection)
        self._iconHeight.update(traitCollection: traitCollection)

        self.bottomLineHeightConstraint?.constant = self.borderLineHeight
        self.stackView.layoutMargins = self.edgeInsets
    }

    // MARK: - Private functions
    private func setupSubscriptions() {
        self.viewModel.$content.subscribe(in: &self.subscriptions) { [weak self] itemContent in
            guard let self else { return }
            self.addOrRemoveIcon(itemContent.icon)
            self.addOrRemoveLabel(itemContent.text)
        }

        self.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { [weak self] attributes in
            guard let self else { return }
            self.setupColors(attributes: attributes)
            self.button.isUserInteractionEnabled = self.viewModel.isEnabled
            self.updateIconConstraints(size: attributes.font.uiFont.lineHeight)
        }
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.accessibilityIdentifier = TabItemAccessibilityIdentifier.tabItem
        self.stackView.spacing = self.spacing
        self.stackView.layoutMargins = self.edgeInsets

        self.addSubviewSizedEqually(self.stackView)

        self.addSubview(self.bottomLine)
        self.bringSubviewToFront(self.bottomLine)

        self.addSubviewSizedEqually(self.button)

        self.setupColors(attributes: self.viewModel.tabStateAttributes)
    }

    private func setupColors(attributes: TabStateAttributes) {
        self.label?.font = attributes.font.uiFont
        self.label?.textColor = attributes.colors.label.uiColor

        self.imageView?.tintColor = attributes.colors.label.uiColor
        self.bottomLine.backgroundColor = attributes.colors.line.uiColor
        self.bottomLine.layer.opacity = Float(attributes.opacity)
        self.stackView.backgroundColor = attributes.colors.background.uiColor
        self.stackView.layer.opacity = Float(attributes.opacity)
    }

    private func updateIconConstraints(size: CGFloat) {
        self.iconHeight = size
        self.imageViewHeightConstraint?.constant = self.iconHeight
    }

    private func setupConstraints() {
        let lineHeightConstraint = self.bottomLine.heightAnchor.constraint(equalToConstant: self.borderLineHeight)

        NSLayoutConstraint.activate([
            lineHeightConstraint,
            self.bottomLine.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            self.bottomLine.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            self.bottomLine.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor)
        ])
        self.bottomLineHeightConstraint = lineHeightConstraint
    }

    private func enableImageSizeConstraints() {
        guard let imageView = self.imageView  else { return }
        if self.imageViewHeightConstraint == nil {
            self.imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: self.viewModel.tabStateAttributes.font.uiFont.lineHeight)

        }
        self.imageViewHeightConstraint?.isActive = true
    }

    private func disableImageViewSizeConstraints() {
        self.imageViewHeightConstraint?.isActive = false
        self.imageViewHeightConstraint = nil
    }

    private func setupButtonActions() {
        let actions: [(selector: Selector, event: UIControl.Event)] = [
            (#selector(actionTapped(sender:)), .touchUpInside),
            (#selector(actionTouchDown(sender:)), .touchDown),
            (#selector(actionTouchUp(sender:)), .touchUpOutside),
            (#selector(actionTouchUp(sender:)), .touchCancel)
        ]

        for action in actions {
            self.button.addTarget(self, action: action.selector, for: action.event)
        }
    }

    private func addOrRemoveIcon(_ icon: UIImage?) {
        if let icon = icon {
            if let image = self.imageView {
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
            } else {
                let image = UIImageView.standard
                image.image = icon
                image.tintColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                self.imageView = image
            }
        } else {
            self.imageView = nil
        }
    }

    private func addOrRemoveLabel(_ text: String?) {
        if let text = text {
            if let label = self.label {
                label.text = text
            } else {
                let label = UILabel.standard
                label.text = text
                label.textColor = self.viewModel.tabStateAttributes.colors.label.uiColor
                label.font = self.viewModel.tabStateAttributes.font.uiFont
                self.label = label
            }
        } else {
            self.label = nil
        }
    }

    @IBAction func actionTapped(sender: UIButton)  {
        self.viewModel.isPressed = false
    }

    @IBAction func actionTouchDown(sender: UIButton)  {
        self.viewModel.isPressed = true
    }

    @IBAction func actionTouchUp(sender: UIButton)  {
        self.viewModel.isPressed = false
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
