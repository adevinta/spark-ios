//
//  BadgeBorder.swift
//  SparkDemo
//
//  Created by alex.vecherov on 17.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct BadgeBorder {
    var width: CGFloat
    let radius: CGFloat
    let color: ColorToken

    mutating func setWidth(_ width: CGFloat) {
        self.width = width
    }
}
