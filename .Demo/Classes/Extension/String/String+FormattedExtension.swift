//
//  String+FormattedExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

extension String {

    var addSpacesBeforeCapitalLetter: String {
        self.map {
            $0.isUppercase ? " \($0)" : String($0)
        }.joined(separator: "")
    }
}
