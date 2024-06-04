//
//  SwitchStatusColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 07/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct SwitchStatusColors {

    // MARK: - Properties

    let onColorToken: any ColorToken
    let offColorToken: any ColorToken
}

// MARK: Hashable & Equatable

extension SwitchStatusColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.onColorToken)
        hasher.combine(self.offColorToken)
    }

    static func == (lhs: SwitchStatusColors, rhs: SwitchStatusColors) -> Bool {
        return lhs.onColorToken.equals(rhs.onColorToken) &&
        lhs.offColorToken.equals(rhs.offColorToken)
    }
}
