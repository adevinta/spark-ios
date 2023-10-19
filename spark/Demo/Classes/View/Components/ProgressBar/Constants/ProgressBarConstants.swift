//
//  ProgressBarConstants.swift
//  Spark
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

enum ProgressBarConstants {

    enum IndicatorValue {
        static let `default` = 50
        static let bottomDefault = Self.default + Self.stepper
        static let range = (1...100)
        static let stepper = 10
        static let multiplier = 0.01
        static var numberFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.multiplier = Self.multiplier as NSNumber
            numberFormatter.maximumFractionDigits = 2
            return numberFormatter
        }()
    }
}
