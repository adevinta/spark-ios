//
//  AddOnUIView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 19.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public final class AddOnTextField: UIView {

    // MARK: - Private enum

    fileprivate enum Side {
        case left
        case right
    }
    
    // MARK: - Private properties

    private let leadingAddOn: UIView?
    private let trailingAddOn: UIView?
    private let viewModel: TextFieldUIViewModel
    private let textField: TextFieldUIView

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: - Initializers

    public init(
        theme: Theme,
        intent: TabIntent,
        leadingAddOn: UIView? = nil,
        trailingAddOn: UIView? = nil
    ) {
        self.leadingAddOn = leadingAddOn
        self.trailingAddOn = trailingAddOn
        self.viewModel = TextFieldUIViewModel(
            theme: theme,
            borderStyle: .roundedRect
        )
        self.textField = TextFieldUIView(viewModel: viewModel)

        super.init(frame: .zero)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hStack.translatesAutoresizingMaskIntoConstraints = false

        self.addSubviewSizedEqually(hStack)

        if let leadingAddOn {
            leadingAddOn.translatesAutoresizingMaskIntoConstraints = false
            leadingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.leadingAddOn
            leadingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            leadingAddOn.setContentHuggingPriority(.required, for: .vertical)
            leadingAddOn.addBorder(toThe: .right)
            hStack.addArrangedSubview(leadingAddOn)
        }

        hStack.addArrangedSubview(textField)

        if let trailingAddOn {
            trailingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.trailingAddOn
            trailingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            trailingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            trailingAddOn.addBorder(toThe: .left)
            hStack.addArrangedSubview(trailingAddOn)
        }
    }

}

private extension UIView {
    func addBorder(toThe side: AddOnTextField.Side) {
        let border = UIView()
        border.backgroundColor = .black

        switch side {
        case .left:
            border.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: 1, height: frame.size.height)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .right:
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            border.frame = CGRect(x: self.frame.maxX - 1, y: self.frame.minY, width: 1, height: frame.size.height)
        }

        self.addSubview(border)
    }
}
