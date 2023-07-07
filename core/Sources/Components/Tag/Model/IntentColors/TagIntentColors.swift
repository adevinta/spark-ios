//
//  TagIntentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

struct TagIntentColors {

    // MARK: - Properties

    let color: any ColorToken
    let onColor: any ColorToken
    let containerColor: any ColorToken
    let onContainerColor: any ColorToken
    let surfaceColor: any ColorToken
}

// MARK: Hashable & Equatable

extension TagIntentColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.color)
        hasher.combine(self.onColor)
        hasher.combine(self.containerColor)
        hasher.combine(self.onContainerColor)
        hasher.combine(self.surfaceColor)
    }

    static func == (lhs: TagIntentColors, rhs: TagIntentColors) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
