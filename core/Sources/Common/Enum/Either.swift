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

// MARK: - Initialization

extension Either {

    /// Try to init the left value.
    /// If left value parameter is nil, the enum is nil
    init?(left: Left?) {
        guard let left else {
            return nil
        }

        self = .left(left)
    }

    /// Try to init the right value.
    /// If right value parameter is nil, the enum is nil
    init?(right: Right?) {
        guard let right else {
            return nil
        }

        self = .right(right)
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
