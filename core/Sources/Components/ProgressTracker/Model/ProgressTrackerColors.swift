//
//  ProgressTrackerColors.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

struct ProgressTrackerColors: Equatable {
    let background: any ColorToken
    let outline: any ColorToken
    let content: any ColorToken
    let label: any ColorToken

    func withOpacity(_ opacity: CGFloat) -> Self {
        return .init(
            background: self.background.opacity(opacity),
            outline: self.background.opacity(opacity),
            content: self.content.opacity(opacity),
            label: self.label.opacity(opacity)
        )
    }

    static func == (lhs: ProgressTrackerColors, rhs: ProgressTrackerColors) -> Bool {
        return lhs.background.equals(rhs.background) &&
        lhs.outline.equals(rhs.outline) &&
        lhs.content.equals(rhs.content) &&
        lhs.label.equals(rhs.label)
    }
}
