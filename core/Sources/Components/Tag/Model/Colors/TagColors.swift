//
//  TagColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct TagColors {

    // MARK: - Properties

    let backgroundColor: any ColorToken
    let borderColor: any ColorToken
    let foregroundColor: any ColorToken
}

// MARK: Hashable & Equatable

extension TagColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.backgroundColor)
        hasher.combine(self.borderColor)
        hasher.combine(self.foregroundColor)
    }

    static func == (lhs: TagColors, rhs: TagColors) -> Bool {
        return lhs.backgroundColor.equals(rhs.backgroundColor) &&
        lhs.borderColor.equals(rhs.borderColor) &&
        lhs.foregroundColor.equals(rhs.foregroundColor)
    }
}
