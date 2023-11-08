//
//  StarFillMode.swift
//  SparkCore
//
//  Created by michael.zimmermann on 07.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@frozen
public enum StarFillMode {
    case full
    case half
    case fraction(_ :CGFloat)
    case exact

    public func rating(of givenValue: CGFloat) -> CGFloat {
        if givenValue > 1 {
            return 1.0
        } else if givenValue <= 0 {
            return 0.0
        }

        switch self {
        case .full: return givenValue.rounded()
        case .half: return givenValue.halfRounded()
        case let .fraction(value): return givenValue.rounded(by: value)
        case .exact: return givenValue
        }
    }
}

private extension CGFloat {
    func rounded(by fraction: CGFloat) -> CGFloat {
        return (self * fraction).rounded() / fraction
    }
    func halfRounded() -> CGFloat {
        return self.rounded(by: 2.0)
    }
}


