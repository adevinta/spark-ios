//
//  TextFieldUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public final class TextFieldUIView: UIControl {

    public let input = TextFieldUIView.InputUIView()

    public var leftIcon: UIImage? {
        didSet {
            // Set logic here
        }
    }

    public var rightIcon: UIImage? {
        didSet {
            self.rightIconView.image = self.rightIcon
            guard self.rightIcon != nil else { return }
            self.statusIconView.isHidden = true
            self.rightIconView.isHidden = false
        }
    }
    private lazy var rightIconView: UIImageView = self.createImageView()

    private var statusIcon: UIImage? {
        didSet {
            self.statusIconView.image = self.statusIcon
            guard self.statusIcon != nil else { return }
            self.statusIconView.isHidden = false
            self.rightIconView.isHidden = true
        }
    }
    private lazy var statusIconView: UIImageView = self.createImageView()

    private lazy var trailingStackView = UIStackView(
        arrangedSubviews: [
            self.statusIconView,
            self.rightIconView
        ]
    )

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.input,
                self.trailingStackView
            ]
        )
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    public init() {
        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .white


        self.addSubview(self.input)
        self.input.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.input.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.input.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.input.topAnchor.constraint(equalTo: self.topAnchor),
            self.input.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.input.widthAnchor.constraint(greaterThanOrEqualToConstant: 280),
            self.input.heightAnchor.constraint(equalToConstant: 44)
        ])

        let leftImageView = self.createImageView()
        leftImageView.image = UIImage(systemName: "square.and.pencil.circle.fill")
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.backgroundColor = .green
        self.input.rightView = leftImageView
//        self.setRightIcon(icon: UIImage(systemName: "square.and.pencil.circle.fill"))
        self.input.rightViewMode = .always

        // Content
//        self.addSubview(self.contentStackView)
//        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
//            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            self.contentStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 280),
//            self.input.heightAnchor.constraint(equalToConstant: 44),
//        ])
    }

//    public func setRightIcon(icon: UIImage?) {
//        let imageView = UIImageView(image: icon)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        let containerView = UIView()
//        containerView.addSubview(imageView)
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
//            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
////            imageView.heightAnchor.constraint(equalToConstant: 40),
////            imageView.widthAnchor.constraint(equalToConstant: 40)
//        ])
//        self.input.rightView = containerView
//    }

    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

}

extension TextFieldUIView {
    public final class InputUIView: UITextField {

//        private var _rightView: UIView? = nil
//        override var rightView: UIView? {
//            get {
//                return self._rightView
//            }
//            set {
//                self._rightView = newValue
//                if let newValue {
//                    let container = UIView()
//                    container.addSubview(newValue)
//                    newValue.translatesAutoresizingMaskIntoConstraints = false
//                    NSLayoutConstraint.activate([
//                        newValue.topAnchor.constraint(equalTo: container.topAnchor),
//                        newValue.bottomAnchor.constraint(equalTo: container.bottomAnchor),
//                        newValue.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
//                        newValue.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
//                    ])
//                    super.rightView = container
//                } else {
//                    super.rightView = nil
//                }
//            }
//        }

//        var padding = UIEdgeInsets(
//            top: 0,
//            left: 16,
//            bottom: 0,
//            right: 16
//        )
//
//        public override func textRect(forBounds bounds: CGRect) -> CGRect {
//            return super.textRect(forBounds: bounds)
//                .inset(by: self.padding)
//        }
//
//        public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//            return super.placeholderRect(forBounds: bounds)
//                .inset(by: self.padding)
//        }
//
//        public override func editingRect(forBounds bounds: CGRect) -> CGRect {
//            return super.editingRect(forBounds: bounds)
//                .inset(by: self.padding)
//        }
//
//        public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
//            return super.clearButtonRect(forBounds: bounds)
//        }
//
//        public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//            return super.rightViewRect(forBounds: bounds)
//        }
//
//        public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//            return super.leftViewRect(forBounds: bounds)
//        }
    }
}
