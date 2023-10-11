//
//  ChipUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// ChipUIView is a control which can act like a button, if an action is attached to it, or it can act like a label.
public final class ChipUIView: UIControl {

    private enum Constants {
        static let touchAreaTolerance: CGFloat = 100
    }

    //MARK: - Public properties
    /// An optional icon on the Chip. The icon is always rendered to the left of the text
    public var icon: UIImage? {
        set {
            self.imageView.image = newValue
            self.imageView.isHidden = newValue == nil
            self.invalidateIntrinsicContentSize()
        }
        get {
            return self.imageView.image
        }
    }

    /// An optional text shown on the Chip. The text is rendered to the right of the icon.
    public var text: String? {
        set {
            self.textLabel.text = newValue
            self.textLabel.isHidden = newValue == nil
            self.invalidateIntrinsicContentSize()
        }
        get {
            return self.textLabel.text
        }
    }

    override public var isEnabled: Bool {
        set {
            self.viewModel.isEnabled = newValue
        }
        get {
            return self.viewModel.isEnabled
        }
    }

    public override var isSelected: Bool {
        set {
            self.viewModel.isSelected = newValue
        }
        get {
            return self.viewModel.isSelected
        }
    }
    
    /// An optional action. If the action is given, the Chip will act like a button and have a pressed state.
    /// As an alternative, a .touchUpInside action can be set
    public var action: (() -> ())? {
        didSet {
            if let uiAction = self.uiAction {
                self.removeAction(uiAction, for: .touchUpInside)
            }
            if let uiAction = self.action.map({ action in
                return UIAction{ _ in action() }
            }) {
                self.uiAction = uiAction
                self.addAction(uiAction, for: .touchUpInside)
            } else {
                self.uiAction = nil
            }
        }
    }

    /// The intent of the chip.
    public var intent: ChipIntent {
        set {
            self.viewModel.set(intent: newValue)
        }
        get {
            return self.viewModel.intent
        }
    }

    /// The variant of the chip
    public var variant: ChipVariant {
        set {
            self.viewModel.set(variant: newValue)
        }
        get {
            return self.viewModel.variant
        }
    }

    public var alignment: ChipAlignment {
        set {
            self.viewModel.set(alignment: newValue)
        }
        get {
            return self.viewModel.alignment
        }
    }
    /// The theme.
    public var theme: Theme {
        set {
            self.viewModel.set(theme: newValue)
        }
        get {
            return self.viewModel.theme
        }
    }

    /// Optional component whicl will be rendered to the right of the label.
    /// Note: the client must be responsible, that it fits within the chip which has a height of 32pts
    public var component: UIView? {
        willSet {
            self.component?.removeFromSuperview()
            if let component = self.component {
                self.stackView.removeArrangedSubview(component)
            }
        }
        didSet {
            if let component = self.component {
                self.stackView.addArrangedSubview(component)
            }
            self.invalidateIntrinsicContentSize()
        }
    }

    public override var intrinsicContentSize: CGSize {

        let width: CGFloat = {
            if let component = self.component, component.intrinsicContentSize.width == UIView.noIntrinsicMetric {
                return UIView.noIntrinsicMetric
            }

            let width: CGFloat = (self.imageView.isHidden ? 0 : self.imageSize)
            + (self.textLabel.isHidden ? 0 : self.textLabel.intrinsicContentSize.width)
            + (self.component?.intrinsicContentSize.width ?? 0.0)

            let spacings = max(0, self.stackView.arrangedSubviews.filter(\.isNotHidden).count - 1)

            return width + (CGFloat(spacings) * self.spacing) + (self.padding * 2.0)
        }()

        return CGSize(width: width, height: self.height)
    }

    //MARK: - Private properties

    var hasAction: Bool {
        return self.allControlEvents == .touchUpInside
    }

    private var uiAction: UIAction?

    private let viewModel: ChipViewModel<Void>

    private var dashBorder: CAShapeLayer?

    @ScaledUIMetric private var imageSize = ChipConstants.imageSize
    @ScaledUIMetric private var height = ChipConstants.height
    @ScaledUIMetric private var borderWidth = ChipConstants.borderWidth
    @ScaledUIMetric private var dashLength = ChipConstants.dashLength
    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var padding: CGFloat
    @ScaledUIMetric private var borderRadius: CGFloat

    public let textLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.accessibilityIdentifier = ChipAccessibilityIdentifier.text
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh,
                                                      for: .horizontal)
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        return label
    }()

    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = ChipAccessibilityIdentifier.icon
        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .vertical)
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var sizeConstraints: [NSLayoutConstraint] = []
    private var heightConstraint: NSLayoutConstraint?
    private var subscriptions = Set<AnyCancellable>()

    //MARK: - Initializers

    /// Initializer of a chip containing only an icon.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - iconImage: An icon
    public convenience init(theme: Theme,
                            intent: ChipIntent,
                            variant: ChipVariant,
                            alignment: ChipAlignment = .leadingIcon,
                            iconImage: UIImage) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  optionalLabel: nil,
                  optionalIconImage: iconImage)
    }

    /// Initializer of a chip containing only a text.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - text: The text label
    public convenience init(theme: Theme,
                            intent: ChipIntent,
                            variant: ChipVariant,
                            alignment: ChipAlignment = .leadingIcon,
                            label: String) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  optionalLabel: label,
                  optionalIconImage: nil)
    }

    /// Initializer of a chip containing both a text and an icon.
    ///
    /// Parameters:
    /// - theme: The theme.
    /// - intent: The intent of the chip, e.g. main, support
    /// - variant: The chip variant, e.g. outlined, filled
    /// - text: The text label
    /// - iconImage: An icon
    public convenience init(theme: Theme,
                            intent: ChipIntent,
                            variant: ChipVariant,
                            alignment: ChipAlignment = .leadingIcon,
                            label: String,
                            iconImage: UIImage) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  optionalLabel: label ,
                  optionalIconImage: iconImage)
    }

    init(theme: Theme,
         intent: ChipIntent,
         variant: ChipVariant,
         alignment: ChipAlignment = .leadingIcon,
         optionalLabel: String?,
         optionalIconImage: UIImage?) {

        self.viewModel = ChipViewModel<Void>(
            theme: theme,
            variant: variant,
            intent: intent,
            alignment: alignment,
            content: Void()
        )
        self.spacing = self.viewModel.spacing
        self.padding = self.viewModel.padding
        self.borderRadius = self.viewModel.borderRadius

        super.init(frame: CGRect.zero)

        self.icon = optionalIconImage
        self.text = optionalLabel
        self.textLabel.sizeToFit()

        self.setupView()
    }

    /// Function traitCollectionDidChange: all dynamic sizing and padding will be recalculated here
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.updateScaledMetrics()

        self.sizeConstraints.forEach{
            $0.constant = self.imageSize
        }

        self.stackView.spacing = self.spacing
        self.heightConstraint?.constant = self.height

        self.updateLayoutMargins()
        self.updateBorder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.removeDashedBorder()

        if self.viewModel.isBorderDashed {
            self.addDashedBorder(borderColor: self.viewModel.colors.border)
        }
    }

    //MARK: - Private functions
    /// Update all colors used
    private func setChipColors(_ chipColors: ChipStateColors) {
        self.stackView.backgroundColor = chipColors.background.uiColor
        self.textLabel.textColor = chipColors.foreground.uiColor
        self.imageView.tintColor = chipColors.foreground.uiColor
        self.layer.opacity = Float(chipColors.opacity)

        if self.viewModel.isBorderDashed {
            self.removeBorder()
            self.addDashedBorder(borderColor: chipColors.border)
        } else if viewModel.isBordered {
            self.removeDashedBorder()
            self.stackView.layer.borderWidth = self.borderWidth
            self.stackView.layer.borderColor = chipColors.border.uiColor.cgColor
        } else {
            self.stackView.layer.borderWidth = 0
            self.stackView.layer.borderColor = nil
        }
    }

    /// Update all scaled metrics
    private func updateScaledMetrics() {
        self._imageSize.update(traitCollection: self.traitCollection)
        self._height.update(traitCollection: self.traitCollection)
        self._spacing.update(traitCollection: self.traitCollection)
        self._padding.update(traitCollection: self.traitCollection)
        self._borderRadius.update(traitCollection: self.traitCollection)
        self._borderWidth.update(traitCollection: self.traitCollection)
        self._dashLength.update(traitCollection: self.traitCollection)
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.stackView)
        if self.viewModel.isIconLeading {
            self.stackView.addArrangedSubviews([self.imageView, self.textLabel])
        } else  {
            self.stackView.addArrangedSubviews([self.textLabel, self.imageView])
        }

        self.updateFont()
        self.updateSpacing()
        self.updateLayoutMargins()

        self.setupConstraints()
        self.setChipColors(self.viewModel.colors)
        self.setupSubscriptions()

        self.accessibilityIdentifier = ChipAccessibilityIdentifier.identifier
    }

    private func updateLayoutMargins() {
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: self.padding, bottom: 0, right: self.padding)
        self.invalidateIntrinsicContentSize()
    }

    private func updateSpacing() {
        self.stackView.spacing = self.spacing
        self.invalidateIntrinsicContentSize()
    }

    private func updateBorder() {
        self.stackView.layer.cornerRadius = self.borderRadius
        self.removeBorder()

        if self.viewModel.isBorderDashed {
            self.addDashedBorder(borderColor: self.viewModel.colors.border)
        } else if self.viewModel.isBordered {
            self.stackView.layer.borderWidth = self.borderWidth
            self.stackView.layer.borderColor = self.viewModel.colors.border.uiColor.cgColor
        }
    }

    private func removeDashedBorder() {
        self.dashBorder?.removeFromSuperlayer()
        self.dashBorder = nil
    }

    private func removeBorder() {
        self.stackView.layer.borderWidth = 0
        self.stackView.layer.borderColor = nil
        self.removeDashedBorder()
    }

    private func updateFont() {
        self.textLabel.font = self.viewModel.font.uiFont
        self.invalidateIntrinsicContentSize()
    }

    private func setupConstraints() {
        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: self.height)

        let sizeConstraints = [
            self.imageView.heightAnchor.constraint(equalToConstant: self.imageSize),
            self.imageView.widthAnchor.constraint(equalToConstant: self.imageSize)
        ]

        let stackConstraints = [
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            heightConstraint,
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(stackConstraints)

        self.stackView.layer.cornerRadius = self.borderRadius
        self.stackView.layer.masksToBounds = true

        self.sizeConstraints = sizeConstraints
        self.heightConstraint = heightConstraint

        NSLayoutConstraint.activate(self.sizeConstraints)

        self.imageView.isHidden = self.icon == nil
        self.textLabel.isHidden = self.text == nil
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            UIView.animate(withDuration: 0.1, animations: { self?.setChipColors(colors) }) 
        }

        self.viewModel.$spacing.subscribe(in: &self.subscriptions) { [weak self] spacing in
            guard let self else { return }
            self.spacing = spacing
            self.updateSpacing()
        }

        self.viewModel.$padding.subscribe(in: &self.subscriptions) { [weak self] padding in
            guard let self else { return }
            self.padding = padding
            self.updateLayoutMargins()
        }
        
        self.viewModel.$borderRadius.subscribe(in: &self.subscriptions) { [weak self] borderRadius in
            guard let self else { return }
            self.borderRadius = borderRadius
            self.updateBorder()
        }

        self.viewModel.$font.subscribe(in: &self.subscriptions) { [weak self] _ in
            self?.updateFont()
        }

        self.viewModel.$isIconLeading.subscribe(in: &self.subscriptions) { [weak self] isLeading in
            self?.updateImagePosition(isIconLeading: isLeading)
        }
    }

    private func addDashedBorder(borderColor: any ColorToken) {
        let dashBorder = CAShapeLayer()
        let bounds = self.stackView.bounds
        dashBorder.lineWidth = self.borderWidth
        dashBorder.strokeColor = borderColor.uiColor.cgColor
        dashBorder.lineDashPattern = [self.dashLength, self.dashLength] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil

        if borderRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.borderRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        self.stackView.layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }

    private func updateImagePosition(isIconLeading: Bool) {
        let newImageIndex = isIconLeading ? 0 : 1

        guard self.stackView.arrangedSubviews.firstIndex(of: self.imageView) != newImageIndex else { return }

        self.stackView.removeArrangedSubview(imageView)
        self.stackView.insertArrangedSubview(imageView, at: newImageIndex)
    }

    // MARK: - Control functions
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if self.hasAction {
            self.viewModel.isPressed = true
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if self.hasAction {
            self.viewModel.isPressed = false
        }
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        if self.hasAction {
            self.viewModel.isPressed = false
        }
    }
}

// MARK: - Label priorities
public extension ChipUIView {
    func setLabelContentCompressionResistancePriority(_ priority: UILayoutPriority,
                                                      for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentCompressionResistancePriority(priority,
                                                               for: axis)
    }

    func setLabelContentHuggingPriority(_ priority: UILayoutPriority,
                                        for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentHuggingPriority(priority,
                                                 for: axis)
    }
}

private extension CGRect {
    func padded(offset: CGFloat) -> CGRect {

        return CGRect(x: self.minX - offset,
                      y: self.minY - offset,
                      width: self.width + (offset * 2),
                      height: self.height + (offset * 2))
    }
}
