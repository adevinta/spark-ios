//
//  ProgressDoubleBarColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

struct ProgressDoubleBarColors: ProgressBarMainColors {

    // MARK: - Properties

    let trackBackgroundColorToken: any ColorToken
    let indicatorBackgroundColorToken: any ColorToken
    let bottomIndicatorBackgroundColorToken: any ColorToken
}

// MARK: Hashable & Equatable

extension ProgressDoubleBarColors {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.trackBackgroundColorToken)
        hasher.combine(self.indicatorBackgroundColorToken)
        hasher.combine(self.bottomIndicatorBackgroundColorToken)
    }

    static func == (lhs: ProgressDoubleBarColors, rhs: ProgressDoubleBarColors) -> Bool {
        return lhs.trackBackgroundColorToken.equals(rhs.trackBackgroundColorToken) &&
        lhs.indicatorBackgroundColorToken.equals(rhs.indicatorBackgroundColorToken) &&
        lhs.bottomIndicatorBackgroundColorToken.equals(rhs.bottomIndicatorBackgroundColorToken)
    }
}
