//
//  IconCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class IconCell: UITableViewCell, Configurable {

    typealias CellConfigartion = IconConfiguration
    typealias Component = IconUIView

    lazy var component: IconUIView = {
        let view = IconUIView(
            iconImage: UIImage(systemName: "lock.circle") ?? UIImage(),
            theme: SparkTheme.shared,
            intent: .main,
            size: .medium
        )
        view.constraints.forEach { $0.priority = .defaultHigh }
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
