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

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.input,
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

    }
}

extension TextFieldUIView {
    public final class InputUIView: UITextField {

        var insets = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )

        public override func textRect(forBounds bounds: CGRect) -> CGRect {
            return self.setInsets(forBounds: bounds)
        }

        public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return self.setInsets(forBounds: bounds)
        }
        public override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return self.setInsets(forBounds: bounds)
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
                if button.frame.origin.x > 0 {
                    totalInsets.right += button.bounds.size.width + 12
                }
            }
            return bounds.inset(by: totalInsets)
        }
    }
}
