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
            checkedImage: DemoIconography.shared.uiCheckmark,
            isEnabled: true,
            selectionState: .selected,
            alignment: .left
        )
        return view
    }()

    var stackViewAlignment: UIStackView.Alignment {
        return .fill
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(configuration: CellConfigartion) {
        self.component.isEnabled = configuration.isEnabled
        self.component.theme = configuration.theme
        self.component.intent = configuration.intent
        self.component.alignment = configuration.alignment
        self.component.text = configuration.text
        self.component.selectionState = configuration.selectionState

        if let icon = configuration.icon {
            self.component.checkedImage = icon
        } else {
            self.component.checkedImage = DemoIconography.shared.uiCheckmark
        }
    }
}
