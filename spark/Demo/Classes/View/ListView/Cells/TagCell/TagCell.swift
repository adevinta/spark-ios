//
//  TagCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class TagCell: UITableViewCell, Configurable {

    typealias CellConfigartion = TagConfiguration
    typealias Component = TagUIView

    lazy var component: TagUIView = {
        return TagUIView(
            theme: SparkTheme.shared,
            intent: .main,
            variant: .filled,
            text: "Tag"
        )
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
        self.component.variant = configuration.variant

        switch configuration.content {
        case .icon:
            self.component.iconImage = UIImage(systemName: "pencil.tip.crop.circle")
            self.component.text = nil
        case .text, .longText:
            self.component.text = "Tag 1"
            self.component.iconImage = nil
        case .attributedText, .longAttributedText:
            self.component.attributedText = NSAttributedString(string: "Tag 3")
        case .iconAndText, .iconAndLongText:
            self.component.text = "Tag 2"
            self.component.iconImage = UIImage(systemName: "pencil.tip.crop.circle")
        case .iconAndAttributedText, .iconAndLongAttributedText:
            self.component.attributedText = NSAttributedString(string: "Tag 4")
            self.component.iconImage = UIImage(systemName: "pencil.tip.crop.circle")
        }
    }
}
