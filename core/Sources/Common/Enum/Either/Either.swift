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

    var optinalLeftValue: Left? {
        switch self {
        case let .left(value): return value
        case .right: return nil
        }
    }

    var optinalRightValue: Right? {
        switch self {
        case let .right(value): return value
        case .left: return nil
        }
    }
}

extension Either {
    static func of(_ left: Left?, or right: Right) -> Either {
        if let left = left {
            return .left(left)
        } else {
            return .right(right)
        }
    }
}
