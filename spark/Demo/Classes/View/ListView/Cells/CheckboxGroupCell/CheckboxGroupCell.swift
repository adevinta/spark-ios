//
//  CheckboxGroupCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class CheckboxGroupCell: UITableViewCell, Configurable {

    typealias CellConfigartion = CheckboxGroupConfiguration
    typealias Component = CheckboxGroupUIView

    lazy var component: CheckboxGroupUIView = {
        let items = [
            CheckboxGroupItemDefault(title: "Text", id: "1", selectionState: .selected, isEnabled: true),
            CheckboxGroupItemDefault(title: "Text 2", id: "2", selectionState: .unselected, isEnabled: true)
        ]

        let view = CheckboxGroupUIView(
            checkedImage: DemoIconography.shared.checkmark,
            items: items,
            alignment: .left,
            theme: SparkTheme.shared,
            intent: .main,
            accessibilityIdentifierPrefix: "CheckboxGroup"
        )
        return view
    }()

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
