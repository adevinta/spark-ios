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
        let rightImageView = self.createImageView()
        leftImageView.image = UIImage(systemName: "square.and.pencil.circle.fill")
        rightImageView.image = UIImage(systemName: "square.and.pencil.circle.fill")
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
//        rightImageView.backgroundColor = .green
//        leftImageView.backgroundColor = .green
        self.input.leftView = leftImageView
        self.input.rightView = rightImageView
//        self.setRightIcon(icon: UIImage(systemName: "square.and.pencil.circle.fill"))
        self.input.leftViewMode = .never
        self.input.rightViewMode = .never

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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
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

        var insets = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
//
        public override func textRect(forBounds bounds: CGRect) -> CGRect {
            return self.setInsets(forBounds: bounds)
        }
//
//        public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//            return super.placeholderRect(forBounds: bounds)
//                .inset(by: self.padding)
//        }
//
        public override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return setInsets(forBounds: bounds)
        }

        public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
            var rect = super.clearButtonRect(forBounds: bounds)
                rect.origin.x -= insets.right
            return rect
        }

        public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            var rect = super.rightViewRect(forBounds: bounds)
                rect.origin.x -= insets.right
            return rect
        }

        public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var rect = super.leftViewRect(forBounds: bounds)
            rect.origin.x += insets.left

            return rect
        }

        private func setInsets(forBounds bounds: CGRect) -> CGRect {

            var totalInsets = self.insets
            if let leftView = self.leftView, leftView.frame.origin.x > 0  { totalInsets.left += leftView.bounds.size.width + 8 }
            if let rightView = self.rightView, rightView.frame.origin.x > 0 { totalInsets.right += rightView.bounds.size.width + 8 }
            if let button = self.value(forKeyPath: "_clearButton") as? UIButton {
                print(button.frame.origin.x)
                if button.frame.origin.x > 0 {
                    totalInsets.right += button.bounds.size.width + 8
                }
            }


            return bounds.inset(by: totalInsets)
        }
    }
}
