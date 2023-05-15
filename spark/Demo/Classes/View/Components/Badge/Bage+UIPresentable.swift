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

struct UIBadgeView: UIViewRepresentable {

    func makeUIView(context: Context) -> some UIView {
        let uiview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 50)))
        uiview.backgroundColor = .cyan
        let badgeView = BadgeUIView(
            viewModel: BadgeViewModel(
                theme: SparkTheme.shared,
                badgeType: .danger
            )
        )
        uiview.addSubview(badgeView)
        NSLayoutConstraint.activate([
            badgeView.trailingAnchor.constraint(equalTo: uiview.trailingAnchor, constant: 0),
            badgeView.centerYAnchor.constraint(equalTo: uiview.centerYAnchor, constant: 0)
        ])
        return uiview
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

