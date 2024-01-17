//
//  AddOnTextFieldCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class AddOnTextFieldCell: UITableViewCell, Configurable {

    typealias CellConfigartion = AddOnTextFieldConfiguration
    typealias Component = AddOnTextFieldUIView

    lazy var component: AddOnTextFieldUIView = {
        let view = AddOnTextFieldUIView(
            theme: SparkTheme.shared,
            intent: .neutral,
            leadingAddOn: nil,
            trailingAddOn: nil
        )
        view.textField.leftView = UIImageView(image: UIImage(systemName: "rectangle.lefthalf.filled"))
        view.textField.rightView = UIImageView(image: UIImage(systemName: "square.rightthird.inset.filled"))
        return view
    }()

    var stackViewAlignment: UIStackView.Alignment {
        return .fill
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(configuration: CellConfigartion) {
        self.component.theme = configuration.theme
        self.component.intent = configuration.intent
        self.component.textField.leftViewMode = .init(rawValue: configuration.leftViewMode.rawValue) ?? .never
        self.component.textField.rightViewMode = .init(rawValue: configuration.rightViewMode.rawValue) ?? .never
        self.component.textField.clearButtonMode = .init(rawValue: configuration.clearButtonMode.rawValue) ?? .never
        self.component.leadingAddOn = createAddOnView(option: configuration.leadingAddOnOption)
        self.component.trailingAddOn = createAddOnView(option: configuration.trailingAddOnOption)
        self.component.textField.text = configuration.text
    }
}

// MARK: - Helper
extension AddOnTextFieldCell {

    func createAddOnView(option: AddOnOption) -> UIView? {
        switch option {
        case .button:
            return self.createButtonAddOn()
        case .shortText:
            return self.createTextAddOn(text: "short")
        case .longText:
            return self.createTextAddOn(text: "very long text")
        case .none:
            return nil
        }
    }

    func createButtonAddOn() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(scale: .small)
        )
        button.configuration = buttonConfig
        button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width).isActive = true
        return button
    }

    private func createTextAddOn(text: String) -> UIView {
        let container = UIView()
        let label = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 32),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        label.textColor = .black
        return container
    }
}
