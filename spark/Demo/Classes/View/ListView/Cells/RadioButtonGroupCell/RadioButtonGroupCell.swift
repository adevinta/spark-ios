//
//  RadioButtonGroupCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class RadioButtonGroupCell: UITableViewCell, Configurable {

    typealias CellConfigartion = RadioButtonGroupConfiguration
    typealias Component = RadioButtonUIGroupView

    lazy var component: RadioButtonUIGroupView = {
        let items = [
            RadioButtonUIItem<Int>.init(id: 0, label: "This is"),
            RadioButtonUIItem<Int>.init(id: 1, label: "A radio"),
            RadioButtonUIItem<Int>.init(id: 2, label: "Button")
        ]
        let view = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            intent: .main,
            selectedID: 0,
            items: items,
            labelAlignment: .trailing,
            groupLayout: .vertical
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
