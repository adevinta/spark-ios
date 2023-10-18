//
//  ProgressBarConstants.swift
//  Spark
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum ProgressBarConstants {

    enum IndicatorValue {
        static let `default` = 50
        static let bottomDefault = Self.default + Self.stepper
        static let range = (1...100)
        static let stepper = 10
        static let conversion: Double = 0.01
    }

    enum IndicatorCornerRadius {
        static let `default` = 0
        static let range = (0...4)
        static let stepper = 1
        static let conversion: Double = 1
    }
}
