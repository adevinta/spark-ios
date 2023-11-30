//
//  NumberFormatter.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension NumberFormatter {
    func multipling(_ value: NSNumber) -> Self {
        self.multiplier = value
        return self
    }

    func maximizingFractionDigits(_ value: Int) -> Self {
        self.maximumFractionDigits = value
        return self
    }
}
