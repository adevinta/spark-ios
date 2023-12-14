//
//  CheckboxCell.swift
//  Spark
//
//  Created by alican.aycil on 14.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class CheckboxCell: UITableViewCell, Configurable {

    typealias CellConfigartion = CheckboxConfiguration
    typealias Component = CheckboxUIView

    lazy var component: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: SparkTheme.shared,
            text: "Checkbox",
            checkedImage: DemoIconography.shared.checkmark,
            isEnabled: true,
            selectionState: .selected,
            alignment: .left
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
