//
//  Either+AttributedStringEquatable.swift
//  SparkCore
//
//  Created by robin.lemaire on 04/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

typealias AttributedStringEither = Either<NSAttributedString, AttributedString>

extension Optional where Wrapped == AttributedStringEither {

    func isEqual(to: AttributedStringEither?) -> Bool {
        switch (self, to) {
        case let (.left(leftLhs), .left(leftRhs)):
            return leftLhs == leftRhs

        case let (.right(rightLhs), .right(rightRhs)):
            return rightLhs == rightRhs

        case (nil, nil):
            return true

        default:
            return false
        }
    }
}
