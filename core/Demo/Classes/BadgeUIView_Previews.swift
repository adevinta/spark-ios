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

    private var viewModels: [BadgeViewModel] =
    [
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            initValue: 6
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .small,
            initValue: 22,
            format: .overflowCounter(maxValue: 20)
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .danger,
            initValue: 10,
            format: .custom(
                formatter: BadgePreviewFormatter()
            )
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .info
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .neutral,
            isOutlined: false
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .primary
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .secondary,
            initValue: 23
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .success
        )
    ]

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
        badgesStackView.distribution = .fill
        return badgesStackView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct BadgeUIView_Previews: PreviewProvider {

    struct BadgeUIViewBridge: View {
        var body: some View {
            UIBadgeView()
                .frame(height: 400)
        }
    }

    static var previews: some View {
        BadgeUIViewBridge()
            .background(Color.gray.opacity(0.4))
    }
}
