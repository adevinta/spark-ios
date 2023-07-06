//
//  Either.swift
//  SparkCore
//
//  Created by michael.zimmermann on 19.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

// MARK: - Equatable

extension Either: Equatable where Left: Equatable, Right: Equatable {
    
    static func == (lhs: Either<Left, Right>, rhs: Either<Left, Right>) -> Bool {
        switch (rhs, lhs) {
        case let (.left(lhs), .left(rhs)):
            return lhs == rhs
        case let (.right(lhs), .right(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

// MARK: - Properties

extension Either {
    var rightValue: Right {
        switch self {
        case let .right(value): return value
        case .left: fatalError("No value for right part")
        }
    }

    var leftValue: Left {
        switch self {
        case let .left(value): return value
        case .right: fatalError("No value for left part")
        }
    }
}
