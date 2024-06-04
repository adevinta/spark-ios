//
//  RadioButtonGroupCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

final class RadioButtonGroupCell: UITableViewCell, Configurable {

    typealias CellConfigartion = RadioButtonGroupConfiguration
    typealias Component = RadioButtonUIGroupView

    var attributeString: NSAttributedString {
        let text: String = "Hello world"
        let attributeString = NSMutableAttributedString(
            string: text,
            attributes: [.font: UIFont.italicSystemFont(ofSize: 18)]
        )
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font: UIFont(
                descriptor: UIFontDescriptor().withSymbolicTraits([.traitBold, .traitItalic]) ?? UIFontDescriptor(),
                size: 18
            ),
            .foregroundColor: UIColor.red
        ]
        attributeString.setAttributes(attributes, range: NSRange(location: 0, length: 5))
        return attributeString
    }

    lazy var component: RadioButtonUIGroupView = {
        let items = [
            RadioButtonUIItem<Int>.init(id: 0, label: "This is"),
            RadioButtonUIItem<Int>.init(id: 1, label: "This is an example of a multi-line text which is very long and in which the user should read all the information."),
            RadioButtonUIItem<Int>.init(id: 2, label: self.attributeString)
        ]
        let view = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            intent: .main,
            selectedID: 0,
            items: items,
            labelAlignment: .trailing,
            groupLayout: .vertical
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
        self.component.theme = configuration.theme
        self.component.intent = configuration.intent
        self.component.groupLayout = configuration.layout
        self.component.isEnabled = configuration.isEnabled
        self.component.selectedID = configuration.selectedID
        self.component.labelAlignment = configuration.alignment
    }
}
