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
        let view = TabUIView(
            theme: SparkTheme.shared,
            intent: .main,
            tabSize: .md,
            content: [TabUIItemContent(title: "Tab 1")]
        )
        return view
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

        if self.component.segments.count == 1 {
            configuration.contents.forEach {
                self.component.addSegment(withImage: $0.icon ?? UIImage(), andTitle: $0.title ?? "")
            }
        }

        if configuration.showBadge {
            self.component.setBadge(self.badge, forSegementAt: 1)
        }
    }
}
