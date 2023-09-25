//
//  TextFieldUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

public final class TextFieldUIView: UITextField {

    private let viewModel: TextFieldUIViewModel
    private var cancellable = Set<AnyCancellable>()

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

    public override var borderStyle: UITextField.BorderStyle {
        set {
            self.viewModel.setBorderStyle(.init(newValue))
        }
        get {
            return .init(self.viewModel.borderStyle)
        }
    }

    public init(theme: Theme,
                intent: TextFieldIntent = .neutral) {
        self.viewModel = TextFieldUIViewModel(theme: theme,
                                              intent: intent,
                                              borderStyle: .none)
        super.init(frame: .zero)
        self.borderStyle = .line
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
        self.setupSubscriptions()
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.subscribe(in: &self.cancellable) { [weak self] colors in
            UIView.animate(withDuration: 0.1, animations: { self?.setupColors(colors) })
        }
        self.viewModel.$borders.subscribe(in: &self.cancellable) { [weak self] borders in
            UIView.animate(withDuration: 0.1, animations: { self?.setupBorders(borders) })
        }
        self.viewModel.$spacings.subscribe(in: &self.cancellable) { [weak self] spacings in
            UIView.animate(withDuration: 0.1, animations: { self?.setNeedsLayout() })
        }
    }

    private func setupColors(_ colors: TextFieldColors) {
        self.setBorderColor(from: colors.border)
    }

    private func setupBorders(_ borders: TextFieldBorders) {
        self.setBorderWidth(borders.width)
        self.setCornerRadius(borders.radius)
    }

    // MARK: - Rects

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
        rect.origin.x -= self.viewModel.spacings.right
        return rect
    }

    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
            rect.origin.x -= self.viewModel.spacings.right
        return rect
    }

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += self.viewModel.spacings.left
        return rect
    }

    private func setInsets(forBounds bounds: CGRect) -> CGRect {
        var totalInsets = UIEdgeInsets(
            top: .zero,
            left: self.viewModel.spacings.left,
            bottom: .zero,
            right: self.viewModel.spacings.right
        )
        let contentSpacing = self.viewModel.spacings.content
        if let leftView = self.leftView, leftView.frame.origin.x > 0 { totalInsets.left += leftView.bounds.size.width + (0.5 * contentSpacing) }
        if let rightView = self.rightView, rightView.frame.origin.x > 0 { totalInsets.right += rightView.bounds.size.width + (0.75 * contentSpacing) }
        if let button = self.value(forKeyPath: "_clearButton") as? UIButton,
           button.frame.origin.x > 0 && !((rightView?.frame.origin.x) ?? 0 > 0) {
                totalInsets.right += button.bounds.size.width + (0.75 * contentSpacing)
        }
        return bounds.inset(by: totalInsets)
    }
}

enum TextFieldBorderStyle {
    case roundedRect
    case line
    case none

    init(_ borderStyle: UITextField.BorderStyle) {
        switch borderStyle {
        case .line, .bezel:
            self = .line
        case .roundedRect:
            self = .roundedRect
        default:
            self = .none
        }
    }
}

extension UITextField.BorderStyle {
    init(_ borderStyle: TextFieldBorderStyle) {
        switch borderStyle {
        case .line:
            self = .line
        case .roundedRect:
            self = .roundedRect
        case .none:
            self = .none
        }

    }
}
