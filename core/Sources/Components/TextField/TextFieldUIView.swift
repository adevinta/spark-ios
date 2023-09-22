//
//  TextFieldUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

public final class TextFieldUIView: UIControl {

    public let input: TextFieldUIView.InputUIView
    private let viewModel: TextFieldUIViewModel
    private var cancellable = Set<AnyCancellable>()

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

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.setTheme(newValue)
        }
    }

    public var intent: TextFieldIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.setIntent(newValue)
        }
    }

    public var borderStyle: TextFieldBorder {
        get {
            return self.viewModel.borderStyle
        }
        set {
            self.setupBorder(borderStyle: newValue)
        }
    }

    public init(theme: Theme,
                intent: TextFieldIntent = .neutral,
                borderStyle: TextFieldBorder = .round) {
        self.viewModel = TextFieldUIViewModel(theme: theme,
                                              intent: intent,
                                              borderStyle: borderStyle)
        self.input = TextFieldUIView.InputUIView(theme: theme)
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
        self.setupSubscriptions()
    }

    func setupBorder(borderStyle: TextFieldBorder) {
        switch borderStyle {
        case .round:
            self.input.layer.borderWidth = 1
            self.input.layer.cornerRadius = 16
        case .none:
            self.input.layer.borderWidth = 0
        }
    }

    func setupTextFieldColors(colors: TextFieldColors) {
        self.input.setBorderColor(from: colors.borderColor)
        //So on for helper text, label and icon
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.subscribe(in: &self.cancellable) { [weak self] colors in
            UIView.animate(withDuration: 0.1, animations: { self?.setupTextFieldColors(colors: colors) })
        }
        self.viewModel.$borderStyle.subscribe(in: &self.cancellable) { [weak self] border in
            UIView.animate(withDuration: 0.1, animations: { self?.setupBorder(borderStyle: border)})
        }
    }
}

extension TextFieldUIView {
    public final class InputUIView: UITextField {

        public var spacing: CGFloat

        init(theme: Theme) {
            self.spacing = theme.layout.spacing.medium
            super.init(frame: .zero)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

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
            if let leftView = self.leftView, leftView.frame.origin.x > 0 { totalInsets.left += leftView.bounds.size.width + (0.5 * self.spacing) }
            if let rightView = self.rightView, rightView.frame.origin.x > 0 { totalInsets.right += rightView.bounds.size.width + (0.75 * self.spacing) }
            if let button = self.value(forKeyPath: "_clearButton") as? UIButton {
                if button.frame.origin.x > 0 && !((rightView?.frame.origin.x) ?? 0 > 0) {
                    totalInsets.right += button.bounds.size.width + (0.75 * self.spacing)
                }
            }
            return bounds.inset(by: totalInsets)
        }
    }
}

public enum TextFieldBorder {
    case round
    case none
}
