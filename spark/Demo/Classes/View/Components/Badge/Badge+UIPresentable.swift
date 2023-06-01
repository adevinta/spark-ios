//
//  Bage+UIPresentable.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

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
    var viewModels: [BadgeViewModel]

    func makeUIView(context: Context) -> some UIView {
        let badgeViews = viewModels.enumerated().map { index, viewModel in
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            let badgeView = BadgeUIView(viewModel: viewModel)
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "badge_\(index)"
            containerView.addSubview(label)
            containerView.addSubview(badgeView)
            containerView.backgroundColor = .blue

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor),
                label.topAnchor.constraint(equalTo: containerView.topAnchor),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            if index >= 3 && index <= 6 {
                NSLayoutConstraint.activate([
                    badgeView.centerXAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
                    badgeView.centerYAnchor.constraint(equalTo: label.topAnchor, constant: -5)
                ])
            } else {
                NSLayoutConstraint.activate([
                    badgeView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
                    badgeView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0)
                ])
            }

            return containerView
        }
        let badgesStackView = UIStackView(arrangedSubviews: badgeViews)
        badgesStackView.axis = .vertical
        badgesStackView.alignment = .leading
        badgesStackView.spacing = 30
        return badgesStackView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

