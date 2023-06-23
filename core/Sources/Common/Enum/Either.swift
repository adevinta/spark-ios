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

extension Either {
    var rightValue: Right {
        switch self {
        case let .right(value): return value
        case .left: fatalError("No right value")
        }
    }

    var leftValue: Left {
        switch self {
        case let .left(value): return value
        case .right: fatalError("No value for left part")
        }
    }
}
