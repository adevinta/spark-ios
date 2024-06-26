//
//  BadgeTableViewCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 12.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class BadgeCell: UITableViewCell, Configurable {

    typealias CellConfigartion = BadgeConfiguration
    typealias Component = BadgeUIView

    lazy var component: BadgeUIView = {
        return BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .main,
            size: .medium,
            value: 99,
            format: .default,
            isBorderVisible: false
        )
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
        self.component.value = configuration.value
        self.component.format = configuration.format
    }
}
