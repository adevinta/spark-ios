//
//  CaseIterable+NameExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

extension CaseIterable {
    static var random: Self {
        return self.allCases.randomElement()!
    }
}
