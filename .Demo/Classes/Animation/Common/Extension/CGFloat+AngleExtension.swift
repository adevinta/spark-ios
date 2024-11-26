//
//  CGFloat+AngleExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// TODO: tester

internal extension CGFloat {

    var degreesToRadians: Self {
        return self * .pi / 180
    }
}
