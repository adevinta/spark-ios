//
//  CaseIterable+NameExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

extension CaseIterable {
    var name: String {
        return "\(self)".capitalizingFirstLetter
    }
}

private extension String {
    var capitalizingFirstLetter: String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
