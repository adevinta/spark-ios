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

    public var text: String? {
        set {
            self.uiLabel.text = newValue
        }
        get {
            return self.uiLabel.text
        }
    }
    public var image: UIImage? {
        set {
            self.uiImageView.image = newValue
        }
        get {
            return self.uiImageView.image
        }
    }

    public var action: (() -> ())? {
        didSet {
            setupButtonActions()
        }
    }

    public var intentColor: ChipIntentColor {
        set {
            self.viewModel.intentColor = newValue
        }
        get {
            return self.viewModel.intentColor
        }
    }

    public var variant: ChipVariant {
        set {
            self.viewModel.variant = newValue
        }
        get {
            return self.viewModel.variant
        }
    }

    public var theme: Theme {
        set {
            self.viewModel.theme = newValue
        }
        get {
            return self.viewModel.theme
        }
    }

    private let viewModel: ChipViewModel

    private let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
    private var dashBorder: CAShapeLayer?

    private var imageSize: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.imageSize, compatibleWith: traitCollection)
    }

    private var height: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.height, compatibleWith: traitCollection)
    }

    private var touchAreaPadding: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.touchAreaPadding, compatibleWith: traitCollection)
    }

    private var spacing: CGFloat {
        self.bodyFontMetrics.scaledValue(for: self.viewModel.spacing, compatibleWith: traitCollection)
    }

    private var padding: CGFloat {
        self.bodyFontMetrics.scaledValue(for: self.viewModel.padding, compatibleWith: traitCollection)
    }

    private var borderRadius: CGFloat {
        self.bodyFontMetrics.scaledValue(for: self.viewModel.borderRadius, compatibleWith: traitCollection)
    }

    private var borderWidth: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.borderWidth, compatibleWith: traitCollection)
    }

    private var dashLength: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.dashLength, compatibleWith: traitCollection)
    }

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

    init(theme: Theme,
         intentColor: ChipIntentColor,
         variant: ChipVariant,
         optionalLabel: String?,
         optionalIconImage: UIImage?) {

        self.viewModel = ChipViewModel(theme: theme, variant: variant, intentColor: intentColor)

        super.init(frame: CGRect.zero)

        self.text = optionalLabel
        self.image = optionalIconImage
        self.uiLabel.sizeToFit()

        self.uiLabel.font = self.viewModel.font.uiFont
        setupView()

    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

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
            self.addDashedBorder()
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
            self.addDashedBorder()
        }
    }

    private func setChipColors() {
        self.stackView.backgroundColor = self.viewModel.colors.background.uiColor
        self.uiLabel.textColor = self.viewModel.colors.foreground.uiColor
        self.uiImageView.tintColor = self.viewModel.colors.foreground.uiColor
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

        if self.viewModel.isBorderDashed {
            self.addDashedBorder()
        } else {
            self.stackView.layer.borderWidth = self.borderWidth
            self.stackView.layer.borderColor = self.viewModel.colors.border.uiColor.cgColor
        }

        self.sizeConstraints = sizeConstraints
        self.heightConstraint = heightConstraint
        self.topPaddingConstraint = topPaddingConstraint
        self.bottomPaddingConstraint = bottomPaddingConstraint


        if self.image == nil {
            self.uiImageView.isHidden = true
        } else {
            NSLayoutConstraint.activate(sizeConstraints)
        }

        if self.text == nil {
            self.uiLabel.isHidden = true
        }

        self.viewModel.$colors
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.setChipColors()
            }.store(in: &self.cancellables)

        self.viewModel.$isBorderDashed
            .receive(on: RunLoop.main)
            .sink { [weak self] isDashed in
                if isDashed {
                    self?.removeDashedBorder()
                } else {
                    self?.addDashedBorder()
                }
            }.store(in: &self.cancellables)

        self.setChipColors()
    }

    private func setupButtonActions() {

        if self.action == nil {
            self.button.removeTarget(self, action: #selector(actionTapped(sender:)), for: .touchUpInside)
            self.button.removeTarget(self, action: #selector(actionTouchDown(sender:)), for: .touchDown)
            self.button.removeTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchUpOutside)
            self.button.removeTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchCancel)
        } else {
            self.button.addTarget(self, action: #selector(actionTapped(sender:)), for: .touchUpInside)
            self.button.addTarget(self, action: #selector(actionTouchDown(sender:)), for: .touchDown)
            self.button.addTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchUpOutside)
            self.button.addTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchCancel)
        }
    }

    @IBAction func actionTapped(sender: UIButton)  {
        self.stackView.backgroundColor = self.viewModel.colors.background.uiColor
        self.action?()
      }

      @IBAction func actionTouchDown(sender: UIButton)  {
          self.stackView.backgroundColor = self.viewModel.colors.backgroundPressed.uiColor
      }

      @IBAction func actionTouchUp(sender: UIButton)  {
          self.stackView.backgroundColor = self.viewModel.colors.background.uiColor
      }

    private func removeDashedBorder() {
        self.dashBorder?.removeFromSuperlayer()
        self.dashBorder = nil
    }

    private func addDashedBorder() {
        self.dashBorder?.removeFromSuperlayer()

        let dashBorder = CAShapeLayer()
        let bounds = self.stackView.bounds
        dashBorder.lineWidth = self.borderWidth
        dashBorder.strokeColor = self.viewModel.colors.border.uiColor.cgColor
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
}
