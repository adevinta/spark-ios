//
//  SliderColors.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct SliderColors: Equatable {
    let track: any ColorToken
    let indicator: any ColorToken
    let handle: any ColorToken
    let handleActiveIndicator: any ColorToken

    func withOpacity(_ opacity: CGFloat) -> SliderColors {
        return .init(
            track: self.track.opacity(opacity),
            indicator: self.indicator.opacity(opacity),
            handle: self.handle.opacity(opacity),
            handleActiveIndicator: self.handleActiveIndicator.opacity(opacity)
        )
    }

    static func == (lhs: SliderColors, rhs: SliderColors) -> Bool {
        return lhs.track.equals(rhs.track) &&
        lhs.indicator.equals(rhs.indicator) &&
        lhs.handle.equals(rhs.handle) &&
        lhs.handleActiveIndicator.equals(rhs.handleActiveIndicator)
    }
}
