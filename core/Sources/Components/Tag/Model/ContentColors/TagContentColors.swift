//
//  TagContentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct TagContentColors {

    // MARK: - Properties

    let color: any ColorToken
    let onColor: any ColorToken
    let containerColor: any ColorToken
    let onContainerColor: any ColorToken
}

// MARK: Hashable & Equatable

extension TagContentColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.color)
        hasher.combine(self.onColor)
        hasher.combine(self.containerColor)
        hasher.combine(self.onContainerColor)
    }

    static func == (lhs: TagContentColors, rhs: TagContentColors) -> Bool {
        return lhs.color.equals(rhs.color) &&
        lhs.onColor.equals(rhs.onColor) &&
        lhs.containerColor.equals(rhs.containerColor) &&
        lhs.onContainerColor.equals(rhs.onContainerColor)
    }
}
