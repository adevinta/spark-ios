//
//  StarFillMode.swift
//  SparkCore
//
//  Created by michael.zimmermann on 07.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The star fill mode determins how the star is to be filled
/// - full: the rating will be rounded to the next full number 0/1 and can be only empty or filled.
/// - half: the raing will be rounded to the next half number and can either be empty, half filled and filled.
/// - fraction: The fill rate will be the rating rounded to the neares fraction, e.g. half is fraction 2.
/// - exact: The star will be filled with the exact rating value
@frozen
public enum StarFillMode {
    case full
    case half
    case fraction(_ :CGFloat)
    case exact

    // MARK: - Public functions
    /// function rating
    /// Calculate the rounded rating
    public func rating(of givenValue: CGFloat) -> CGFloat {
        if givenValue > 1 {
            return 1.0
        } else if givenValue <= 0 {
            return 0.0
        }

        switch self {
        case .full: return givenValue.rounded()
        case .half: return givenValue.halfRounded()
        case let .fraction(fraction): return givenValue.rounded(by: fraction)
        case .exact: return givenValue
        }
    }
}

// MARK: - Private helpers
private extension CGFloat {
    func rounded(by fraction: CGFloat) -> CGFloat {
        return (self * fraction).rounded() / fraction
    }
    func halfRounded() -> CGFloat {
        return self.rounded(by: 2.0)
    }
}
