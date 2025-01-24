//
//  String+NumberExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 21/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

extension String {

    var cgFloat: CGFloat? {
        if let doubleValue = Double(self) {
            return CGFloat(doubleValue)
        }
        return nil
    }
}
