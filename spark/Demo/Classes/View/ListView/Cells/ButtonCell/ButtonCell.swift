//
//  ButtonCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class ButtonCell: UITableViewCell, Configurable {

    typealias CellConfigartion = ButtonConfiguration
    typealias Component = ButtonUIView

    lazy var component: ButtonUIView = {
        return ButtonUIView(
            theme: SparkTheme.shared,
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
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
        self.component.variant = configuration.variant
        self.component.size = configuration.size
        self.component.shape = configuration.shape
        self.component.alignment = configuration.alignment
        self.component.isEnabled = configuration.isEnabled

        switch configuration.content {
        case .text:
            self.component.setTitle("Button", for: .normal)
            self.component.setImage(nil, for: .normal)
        case .imageAndText:
            self.component.setTitle("Hello World", for: .normal)
            self.component.setImage(UIImage(systemName: "book.circle"), for: .normal)
        case .attributedText:
            self.component.setAttributedTitle(self.attributeString, for: .normal)
            self.component.setImage(nil, for: .normal)
        default:
            break
        }
    }
}
