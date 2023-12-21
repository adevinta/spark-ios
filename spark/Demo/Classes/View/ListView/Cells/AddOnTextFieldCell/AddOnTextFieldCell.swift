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
    }
}
