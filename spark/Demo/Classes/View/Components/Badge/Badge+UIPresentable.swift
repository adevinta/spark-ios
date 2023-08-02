//
//  Bage+UIPresentable.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "Test \(value)"
    }
}

struct UIBadgeView: UIViewRepresentable {

    let theme: Theme
    let intent: BadgeIntentType
    let size: BadgeSize
    let value: Int?
    let format: BadgeFormat
    let isBorderVisible: Bool

    init(theme: Theme, intent: BadgeIntentType, size: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isBorderVisible: Bool = true) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.value = value
        self.format = format
        self.isBorderVisible = isBorderVisible
    }

    func makeUIView(context: Context) -> BadgeUIView {
        return BadgeUIView(
            theme: theme,
            intent: intent,
            size: size,
            value: value,
            format: format,
            isBorderVisible: isBorderVisible
        )
    }

    func updateUIView(_ badge: BadgeUIView, context: Context) {
        badge.theme = theme
        badge.intent = intent
        badge.size = size
        badge.format = format
        badge.value = value
        badge.isBorderVisible = isBorderVisible
    }
}

