//
//  CGFloat+ScaledMetricExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension CGFloat {

    /// Because the @ScaledMetric cannot be updated,
    /// we add this the scaled metric multiplier value.
    /// This value must be multiplied with you want to make dynamic (width, height, padding, ...)
    /// - note: - Please use this value only for @ScaledMetric on SwiftUI
    ///
    /// **Example**
    /// This example shows how to create view this multiplier on SwiftUI View
    /// ```swift
    ///    @ScaledMetric private var spacingMultiplier: CGFloat = ScaledMetric.scaledMetricMultiplier
    /// ```
    static var scaledMetricMultiplier: CGFloat {
        return 1
    }

    /// Because the @ScaledMetric cannot be updated,
    /// we must multiply the value that you want to make dynamic
    /// with the scaled value mutiliplier get from CGFloat.scaledMetricMultiplier
    /// - Parameter multiplier:  the scaled value mutiliplier get from CGFloat.scaledMetricMultiplier and stock on @ScaledMetric var
    /// - note: - Please use this value only for @ScaledMetric on SwiftUI
    ///
    /// **Example**
    /// This example shows how to implement the scaled metric value for the width of a view
    /// ```swift
    ///    @ScaledMetric private var spacingMultiplier: CGFloat = ScaledMetric.scaledMetricMultiplier
    ///    @ObservedObject private var viewModel: MyViewModel
    ///
    ///    var body: any View {
    ///        Spacer()
    ///            .frame(width: self.viewModel.spacing.scaledMetric(self.spacingMultiplier))
    ///    }
    /// ```
    func scaledMetric(with multiplier: CGFloat) -> CGFloat {
        self * multiplier
    }
}

public extension Optional where Wrapped == CGFloat {

    /// Same as **scaledMetric(with:)** func with optional value
    /// If the CGFloat is nil, the default value is 0
    func scaledMetric(with multiplier: CGFloat) -> CGFloat {
        return (self ?? 0).scaledMetric(with: multiplier)
    }
}
