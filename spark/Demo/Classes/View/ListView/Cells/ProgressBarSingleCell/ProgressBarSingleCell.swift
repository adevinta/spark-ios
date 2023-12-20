//
//  ProgressBarSingleCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class ProgressBarSingleCell: UITableViewCell, Configurable {

    typealias CellConfigartion = ProgressBarSingleConfiguration
    typealias Component = ProgressBarUIView

    lazy var component: ProgressBarUIView = {
        let view = ProgressBarUIView(
            theme: SparkTheme.shared,
            intent: .main,
            shape: .square)
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
