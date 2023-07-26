//
//  Bage+UIPresentable.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import SparkCore
import Spark

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "Test \(value)"
    }
}

struct UIBadgeView: UIViewRepresentable {

    var views: [BadgeUIView]

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    func makeUIView(context: Context) -> some UIView {
        let badgesStackView = UIStackView()
        for view in self.views {
            view.setTheme(self.theme)
        }
        views.enumerated().forEach { index, badgeView in
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "badge_\(index)"
            containerView.addSubview(label)
            containerView.addSubview(badgeView)
            containerView.backgroundColor = .blue

            label.activateConstraint(from: .leading, to: .leading, ofView: containerView, relation: .greaterThanOrEqual)
            label.activateConstraint(from: .top, to: .top, ofView: containerView)
            label.activateConstraint(from: .bottom, to: .bottom, ofView: containerView)

            if index >= 3 && index <= 6 {
                badgeView.activateConstraint(from: .centerX, to: .trailing, ofView: label, constant: 5)
                badgeView.activateConstraint(from: .centerY, to: .top, ofView: label, constant: -5)
            } else {
                badgeView.activateConstraint(from: .leading, to: .trailing, ofView: label, constant: 5)
                badgeView.activateConstraint(from: .centerY, to: .centerY, ofView: label)
            }

            badgesStackView.addArrangedSubview(containerView)
        }
        badgesStackView.axis = .vertical
        badgesStackView.alignment = .leading
        badgesStackView.spacing = 30
        badgesStackView.distribution = .fill

        return badgesStackView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

