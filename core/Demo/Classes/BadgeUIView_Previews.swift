//
//  BadgeUIView_Previews.swift
//  SparkCoreDemo
//
//  Created by alex.vecherov on 22.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "\(value)€"
    }
}

struct UIBadgeView: UIViewRepresentable {

    var views: [BadgeUIView]

    func makeUIView(context: Context) -> some UIView {
        let badgesStackView = UIStackView()
        views.enumerated().forEach { index, badgeView in
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
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

struct BadgeUIView_Previews: PreviewProvider {

    struct BadgeUIViewBridge: View {
        private var views = [
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .alert,
                value: 6
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .main,
                size: .medium,
                value: 22,
                format: .overflowCounter(maxValue: 20)
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .danger,
                value: 10,
                format: .custom(
                    formatter: BadgePreviewFormatter()
                )
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .info,
                value: 20
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .main
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .neutral,
                isBorderVisible: false
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .support,
                value: 23
            ),
            BadgeUIView(
                theme: SparkTheme.shared,
                intent: .success
            )
        ]

        var body: some View {
            List {
                Button("Change UIKit Badge 0 Type") {
                    views[0].setIntent(BadgeIntentType.allCases.randomElement() ?? .alert)
                }
                Button("Change UIKit Badge 1 Value") {
                    views[1].setValue(2)
                }
                Button("Change UIKit Badge 2 Outline") {
                    views[2].setBorderVisible(false)
                }
                Button("Change UIKit Badge 3 Size") {
                    views[3].setSize(.small)
                }
                UIBadgeView(views: views)
                    .frame(height: 400)
                    .listRowBackground(Color.gray.opacity(0.3))
            }
        }
    }

    static var previews: some View {
        BadgeUIViewBridge()
            .background(Color.gray.opacity(0.4))
    }
}
