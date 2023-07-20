//
//  IconColors.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The color of the icon.
struct IconColor {
    let foreground: any ColorToken
}

extension IconColor: Equatable {
    static func == (lhs: IconColor, rhs: IconColor) -> Bool {
        lhs.foreground.hashValue == rhs.foreground.hashValue
    }
}
