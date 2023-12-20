//
//  RadioButtonCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class RadioButtonCell: UITableViewCell, Configurable {

    typealias CellConfigartion = RadioButtonConfiguration
    typealias Component = RadioButtonUIView

    lazy var component: RadioButtonUIView = {
        let view = RadioButtonUIView(
            theme: SparkTheme.shared,
            intent: .main,
            id: 99,
            label: NSAttributedString(string: "Sample of toggle on radio button"),
            isSelected: true
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
