//
//  TextFieldCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class TextFieldCell: UITableViewCell, Configurable {

    typealias CellConfigartion = TextFieldConfiguration
    typealias Component = TextFieldUIView

    lazy var component: TextFieldUIView = {
        let view = TextFieldUIView(theme: SparkTheme.shared)
        view.leftView = UIImageView(image: UIImage(systemName: "rectangle.lefthalf.filled"))
        view.rightView = UIImageView(image: UIImage(systemName: "square.rightthird.inset.filled"))
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
        self.component.leftViewMode = .init(rawValue: configuration.leftViewMode.rawValue) ?? .never
        self.component.rightViewMode = .init(rawValue: configuration.rightViewMode.rawValue) ?? .never
        self.component.clearButtonMode = .init(rawValue: configuration.clearButtonMode.rawValue) ?? .never
        self.component.text = configuration.text
    }
}
