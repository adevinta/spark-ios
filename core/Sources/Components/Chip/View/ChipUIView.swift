//
//  ChipUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

private enum Constants {
    static let imageSize: CGFloat = 13.33
    static let height: CGFloat = 32
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

    private let viewModel: ChipViewModel

    private let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
    private var dashBorder: CAShapeLayer?

    private var imageSize: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.imageSize, compatibleWith: traitCollection)
    }

    private var height: CGFloat {
        self.bodyFontMetrics.scaledValue(for: Constants.height, compatibleWith: traitCollection)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var sizeConstraints: [NSLayoutConstraint] = []
    private var heightConstraint: NSLayoutConstraint?

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

        super.init(frame: CGRect.zero)

        self.text = optionalLabel
        self.image = optionalIconImage
        self.uiLabel.sizeToFit()

        self.uiLabel.font = self.viewModel.font.uiFont
        setupView()

    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("trait collection did change")

        self.sizeConstraints.forEach{
            $0.constant = self.imageSize
        }

        self.stackView.spacing = self.spacing
        self.heightConstraint?.constant = self.height
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: self.padding, bottom: 0, right: self.padding)
        self.layer.cornerRadius = self.borderRadius
        
        if self.viewModel.isBorderDashed {
            self.addDashedBorder()
        } else {
            self.layer.borderWidth = self.borderWidth
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        print("did layout subviews")
        if self.viewModel.isBorderDashed {
            self.addDashedBorder()
        }
    }
    
    private func setupView() {

        print("Setup view")
        addSubview(self.stackView)

        self.backgroundColor = self.viewModel.colors.backgroundColor.uiColor
        self.uiLabel.textColor = self.viewModel.colors.foregroundColor.uiColor
        self.uiImageView.tintColor = self.viewModel.colors.foregroundColor.uiColor

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

        let stackConstraints = [
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            heightConstraint
        ]

        NSLayoutConstraint.activate(stackConstraints)

        self.layer.cornerRadius = self.borderRadius
        self.layer.masksToBounds = true

        if self.viewModel.isBorderDashed {
            self.addDashedBorder()
        } else {
            self.layer.borderWidth = self.borderWidth
            self.layer.borderColor = self.viewModel.colors.borderColor.uiColor.cgColor
        }

        self.sizeConstraints = sizeConstraints
        self.heightConstraint = heightConstraint


        if self.image == nil {
            self.uiImageView.isHidden = true
        } else {
            NSLayoutConstraint.activate(sizeConstraints)
        }

        if self.text == nil {
            self.uiLabel.isHidden = true
        }
    }

    private func addDashedBorder() {
        self.dashBorder?.removeFromSuperlayer()

        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = borderWidth
        dashBorder.strokeColor = viewModel.colors.borderColor.uiColor.cgColor
        dashBorder.lineDashPattern = [self.dashLength, self.dashLength] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil

        if borderRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.borderRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
