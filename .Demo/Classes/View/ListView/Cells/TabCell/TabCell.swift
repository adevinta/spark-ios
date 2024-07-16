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
        return TabUIView(
            theme: SparkTheme.shared,
            intent: .main,
            tabSize: .md,
            content: []
        )
    }()

    var badge: BadgeUIView {
        let badge = BadgeUIView(
            theme: SparkTheme.shared,
            intent: .danger,
            value: 99
        )
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.isBorderVisible = false
        badge.size = .medium
        return badge
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
        self.component.tabSize = configuration.size
        self.component.apportionsSegmentWidthsByContent = !configuration.isEqualWidth
        self.component.setSegments(withContent: configuration.contents)

        if configuration.showBadge {
            self.component.setBadge(self.badge, forSegementAt: 1)
        } else {
            self.component.setBadge(nil, forSegementAt: 1)
        }
    }
}
