//
//  SwitchButtonCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class SwitchButtonCell: UITableViewCell, Configurable {

    typealias CellConfigartion = SwitchButtonConfiguration
    typealias Component = SwitchUIView

    lazy var component: SwitchUIView = {
        let view = SwitchUIView(
            theme: SparkTheme.shared,
            isOn: true,
            alignment: .left,
            intent: .main,
            isEnabled: true,
            images: .init(
                on: UIImage(named: "check") ?? UIImage(),
                off: UIImage(named: "close") ?? UIImage()
            ),
            text: "Text"
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
