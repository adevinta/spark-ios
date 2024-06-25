//
//  ProgressBarValueViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ProgressBarValueViewModel {
    /// Function used to check if the value is valid or not
    /// - Parameter value: should be between 0...1
    /// - Returns: true if the value is valid otherwise false
    func isValidIndicatorValue(_ value: CGFloat) -> Bool
}

extension ProgressBarValueViewModel {

    func isValidIndicatorValue(
        _ value: CGFloat
    ) -> Bool {
        return (0...1).contains(value)
    }
}
