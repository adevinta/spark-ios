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
        return SwitchUIView(
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
    }()

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
        self.component.alignment = configuration.alignment
        self.component.isOn = configuration.isOn
        self.component.isEnabled = configuration.isEnabled

        switch configuration.textContent {
        case .attributedText:
            self.component.attributedText = self.attributeString
        case .multilineText:
            self.component.text = "This is an example of a multi-line text which is very long and in which the user should read all the information."
        case .text:
            self.component.text = "Text"
        case .none:
            self.component.text = nil
        }
    }
}
