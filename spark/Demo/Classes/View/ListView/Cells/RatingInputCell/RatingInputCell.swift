//
//  RatingInputCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class RatingInputCell: UITableViewCell, Configurable {

    typealias CellConfigartion = RatingInputConfiguration
    typealias Component = RatingInputUIView

    lazy var component: RatingInputUIView = {
        let view = RatingInputUIView(
            theme: SparkTheme.shared,
            intent: .main
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
        self.component.rating = configuration.rating
        self.component.isEnabled = configuration.isEnabled
    }
}
