//
//  ProgressBarColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct ProgressBarColors: ProgressBarMainColors {
    
    // MARK: - Properties

    let trackBackgroundColorToken: any ColorToken
    let indicatorBackgroundColorToken: any ColorToken
}

// MARK: Hashable & Equatable

extension ProgressBarColors {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.trackBackgroundColorToken)
        hasher.combine(self.indicatorBackgroundColorToken)
    }

    static func == (lhs: ProgressBarColors, rhs: ProgressBarColors) -> Bool {
        return lhs.trackBackgroundColorToken.equals(rhs.trackBackgroundColorToken) &&
        lhs.indicatorBackgroundColorToken.equals(rhs.indicatorBackgroundColorToken)
    }
}
