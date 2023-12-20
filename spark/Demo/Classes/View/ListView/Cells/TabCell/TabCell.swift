//
//  TabCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class TabCell: UITableViewCell, Configurable {

    typealias CellConfigartion = TabConfiguration
    typealias Component = TabUIView

    lazy var component: TabUIView = {
        let view = TabUIView(
            theme: SparkTheme.shared,
            intent: .main,
            tabSize: .md,
            content: [TabUIItemContent(title: "Tab 1"), TabUIItemContent(title: "Tab 2")]
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
