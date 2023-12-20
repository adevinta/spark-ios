//
//  ChipCell.swift
//  Spark
//
//  Created by alican.aycil on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class ChipCell: UITableViewCell, Configurable {

    typealias CellConfigartion = ChipConfiguration
    typealias Component = ChipUIView

    lazy var component: ChipUIView = {
        let view = ChipUIView(
            theme: SparkTheme.shared,
            intent: .basic,
            variant: .outlined,
            label: "No Title"
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
