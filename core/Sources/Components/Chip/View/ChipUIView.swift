//
//  ChipUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

private enum Constants {
    static let imageSize: CGFloat = 13.33
    static let height: CGFloat = 32
    static let touchAreaPadding: CGFloat = 6
    static let borderWidth: CGFloat = 1
    static let dashLength: CGFloat = 1.9
}

public final class ChipUIView: UIView {

    //MARK: - Public properties
    /// An optional icon on the Chip. This
    public var icon: UIImage? {
        set {
            self.uiImageView.image = newValue
        }
        get {
            return self.uiImageView.image
        }
    }

    /// An optional text shown on the Chip. The text is rendered to the right of the image.
    public var text: String? {
        set {
            self.uiLabel.text = newValue
        }
        get {
            return self.uiLabel.text
        }
    }

    /// An optional action. If the action is given, the Chip will act like a button and have a pressed state.
    public var action: (() -> ())? {
        didSet {
            setupButtonActions()
        }
    }

    /// The intent of the chip.
    public var intentColor: ChipIntentColor {
        set {
            self.viewModel.intentColor = newValue
        }
        get {
            return self.viewModel.intentColor
        }
    }

    /// The variant of the chip
    public var variant: ChipVariant {
        set {
            self.viewModel.variant = newValue
        }
        get {
            return self.viewModel.variant
        }
    }

    /// The theme.
    public var theme: Theme {
        set {
            self.viewModel.theme = newValue
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
        }
        didSet {
            if let component = self.component {
                self.stackView.addArrangedSubview(component)
            }
        }
    }

    //MARK: - Private properties
    private let viewModel: ChipViewModel

    private var dashBorder: CAShapeLayer?

    @ScaledUIMetric private var imageSize = Constants.imageSize
    @ScaledUIMetric private var height = Constants.height
    @ScaledUIMetric private var touchAreaPadding = Constants.touchAreaPadding
    @ScaledUIMetric private var borderWidth = Constants.borderWidth
    @ScaledUIMetric private var dashLength = Constants.dashLength
    @ScaledUIMetric private var spacing: CGFloat
    @ScaledUIMetric private var padding: CGFloat
    @ScaledUIMetric private var borderRadius: CGFloat

    private let uiLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.isAccessibilityElement = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        return label
    }()

    private let uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return button
    }()

    private var sizeConstraints: [NSLayoutConstraint] = []
    private var heightConstraint: NSLayoutConstraint?
    private var topPaddingConstraint: NSLayoutConstraint?
    private var bottomPaddingConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Initializers
    public convenience init(theme: Theme,
                intentColor: ChipIntentColor,
                variant: ChipVariant,
                iconImage: UIImage) {
        self.init(theme: theme, intentColor: intentColor, variant: variant, optionalLabel: nil, optionalIconImage: iconImage)
    }

    public convenience init(theme: Theme,
                intentColor: ChipIntentColor,
                variant: ChipVariant,
                label: String) {
        self.init(theme: theme, intentColor: intentColor, variant: variant, optionalLabel: label, optionalIconImage: nil)
    }

    public convenience init(theme: Theme,
                intentColor: ChipIntentColor,
                variant: ChipVariant,
                label: String,
                iconImage: UIImage) {
        self.init(theme: theme, intentColor: intentColor, variant: variant, optionalLabel: label , optionalIconImage: iconImage)
    }

    init(theme: Theme,
         intentColor: ChipIntentColor,
         variant: ChipVariant,
         optionalLabel: String?,
         optionalIconImage: UIImage?) {

        self.viewModel = ChipViewModel(theme: theme, variant: variant, intentColor: intentColor)
        self.spacing = self.viewModel.spacing
        self.padding = self.viewModel.padding
        self.borderRadius = self.viewModel.borderRadius

        super.init(frame: CGRect.zero)

        self.text = optionalLabel
        self.icon = optionalIconImage
        self.uiLabel.sizeToFit()

        self.uiLabel.font = self.viewModel.font.uiFont
        self.setupView()

    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.updateScaledMetrics()

        self.sizeConstraints.forEach{
            $0.constant = self.imageSize
        }

        self.topPaddingConstraint?.constant = self.touchAreaPadding
        self.bottomPaddingConstraint?.constant = -self.touchAreaPadding

        self.stackView.spacing = self.spacing
        self.heightConstraint?.constant = self.height
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: self.padding, bottom: 0, right: self.padding)
        self.stackView.layer.cornerRadius = self.borderRadius
        
        if self.viewModel.isBorderDashed {
            self.addDashedBorder(borderColor: self.viewModel.colors.default.border)
        } else {
            self.stackView.layer.borderWidth = self.borderWidth
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if self.viewModel.isBorderDashed {
            self.addDashedBorder(borderColor: self.viewModel.colors.default.border)
        }
    }

    //MARK: - Private functions
    private func setChipColors(_ chipColors: ChipStateColors) {
        self.stackView.backgroundColor = chipColors.background.uiColor
        self.uiLabel.textColor = chipColors.foreground.uiColor
        self.uiImageView.tintColor = chipColors.foreground.uiColor

        if self.viewModel.isBorderDashed {
            self.addDashedBorder(borderColor: chipColors.border)
        } else {
            self.stackView.layer.borderWidth = self.borderWidth
            self.stackView.layer.borderColor = chipColors.border.uiColor.cgColor
        }
    }

    private func updateScaledMetrics() {
        self._imageSize.update(traitCollection: self.traitCollection)
        self._height.update(traitCollection: self.traitCollection)
        self._touchAreaPadding.update(traitCollection: self.traitCollection)
        self._spacing.update(traitCollection: self.traitCollection)
        self._padding.update(traitCollection: self.traitCollection)
        self._borderRadius.update(traitCollection: self.traitCollection)
        self._borderWidth.update(traitCollection: self.traitCollection)
        self._dashLength.update(traitCollection: self.traitCollection)
    }
    
    private func setupView() {
        self.addSubview(self.stackView)
        self.addSubview(self.button)
        self.button.frame = self.bounds

        self.stackView.spacing = self.spacing

        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: self.padding, bottom: 0, right: self.padding)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.stackView.addArrangedSubview(self.uiImageView)
        self.stackView.addArrangedSubview(self.uiLabel)

        self.setupConstraints()
        self.setChipColors(self.viewModel.colors.default)
        self.setupSubscriptions()
    }

    private func setupConstraints() {
        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: self.height)

        let sizeConstraints = [
            self.uiImageView.heightAnchor.constraint(equalToConstant: self.imageSize),
            self.uiImageView.widthAnchor.constraint(equalToConstant: self.imageSize)
        ]

        let topPaddingConstraint = self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.touchAreaPadding)
        let bottomPaddingConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -self.touchAreaPadding)

        let stackConstraints = [
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            heightConstraint,
            topPaddingConstraint,
            bottomPaddingConstraint
        ]

        NSLayoutConstraint.activate(stackConstraints)

        self.stackView.layer.cornerRadius = self.borderRadius
        self.stackView.layer.masksToBounds = true

        self.sizeConstraints = sizeConstraints
        self.heightConstraint = heightConstraint
        self.topPaddingConstraint = topPaddingConstraint
        self.bottomPaddingConstraint = bottomPaddingConstraint


        if self.icon == nil {
            self.uiImageView.isHidden = true
        } else {
            NSLayoutConstraint.activate(sizeConstraints)
        }

        if self.text == nil {
            self.uiLabel.isHidden = true
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$colors
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.setChipColors(self.viewModel.colors.default)
            }.store(in: &self.cancellables)

        self.viewModel.$isBorderDashed
            .receive(on: RunLoop.main)
            .sink { [weak self] isDashed in
                guard let self else { return }
                if isDashed {
                    self.addDashedBorder(borderColor: self.viewModel.colors.default.border)
                } else {
                    self.removeDashedBorder()
                }
            }.store(in: &self.cancellables)
    }

    private func removeDashedBorder() {
        self.dashBorder?.removeFromSuperlayer()
        self.dashBorder = nil
    }

    private func addDashedBorder(borderColor: ColorToken) {
        self.dashBorder?.removeFromSuperlayer()

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

    //MARK: Button actions
    private func setupButtonActions() {
        let actions: [(selector: Selector, event: UIControl.Event)] = [
            (#selector(actionTapped(sender:)), .touchUpInside),
            (#selector(actionTouchDown(sender:)), .touchDown),
            (#selector(actionTouchUp(sender:)), .touchUpOutside),
            (#selector(actionTouchUp(sender:)), .touchCancel)
        ]

        if self.action == nil {
            actions.forEach { self.button.removeTarget(self, action: $0.selector, for: $0.event)}
        } else {
            actions.forEach { self.button.addTarget(self, action: $0.selector, for: $0.event)}
        }
    }

    @IBAction func actionTapped(sender: UIButton)  {
        self.setChipColors(self.viewModel.colors.default)
        self.action?()
    }

    @IBAction func actionTouchDown(sender: UIButton)  {
        self.setChipColors(self.viewModel.colors.pressed)
    }

    @IBAction func actionTouchUp(sender: UIButton)  {
        self.setChipColors(self.viewModel.colors.default)
    }

}
