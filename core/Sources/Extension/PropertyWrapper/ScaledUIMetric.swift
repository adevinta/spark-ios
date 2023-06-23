//
//  ScaledUIMetric.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 05.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// ScaledUIMetric is a property wrapper for UIKit. It scales values according to the current trait collection content size and behaves similar to the @`ScaledMetric`-property wrapper for SwiftUI.
@propertyWrapper struct ScaledUIMetric<Value> where Value : BinaryFloatingPoint {
    // MARK: - Properties

    let isAutoscalable: Bool

    /// Returns the scaled value for the `baseValue` according to the trait collection. When setting this property a new baseValue is set.
    var wrappedValue: Value {
        get {
            return self.isAutoscalable ? self.scaledValue(for: self.traitCollection) : self.baseValue
        }
        set {
            self.baseValue = newValue
        }
    }

    /// The base value for the calculation.
    private var baseValue: Value

    /// The font metrics the scaling is based on. The default value is `.body`-text-style.
    private let metrics: UIFontMetrics

    /// The trait collection used for the scaling operation. The default value is nil, which means the current trait collection will be used (`UITraitCollection.current`).
    private var traitCollection: UITraitCollection?

    // MARK: - Initialization

    /// Initialize a new property wrapper.
    /// - Parameters:
    ///   - baseValue: The base value used in the calculation.
    ///   - metrics: The font metrics the scaling is based on.
    ///   - traitCollection: The trait collection used for the scaling operation. The default value is nil, which means the current trait collection will be used (`UITraitCollection.current`).
    init(
        wrappedValue baseValue: Value,
        relativeTo metrics: UIFontMetrics,
        isAutoscalable: Bool = true,
        traitCollection: UITraitCollection? = nil
    ) {
        self.baseValue = baseValue
        self.metrics = metrics
        self.traitCollection = traitCollection
        self.isAutoscalable = isAutoscalable
    }

    /// Initialize a new property wrapper.
    /// - Parameters:
    ///   - baseValue: The base value used in the calculation.
    ///   - metrics: The text style the scaling is based on. The default value is `.body`-text-style.
    ///   - traitCollection: The trait collection used for the scaling operation. The default value is nil, which means the current trait collection will be used (`UITraitCollection.current`).
    init(
        wrappedValue baseValue: Value,
        relativeTo textStyle: UIFont.TextStyle = .body,
        isAutoscalable: Bool = true,
        traitCollection: UITraitCollection? = nil
    ) {
        self.init(
            wrappedValue: baseValue,
            relativeTo: UIFontMetrics(forTextStyle: textStyle),
            isAutoscalable: isAutoscalable,
            traitCollection: traitCollection
        )
    }

    // MARK: - Methods

    /// Update the trait collection.
    /// - Parameter traitCollection: a new trait collection.
    mutating func update(traitCollection: UITraitCollection?) {
        self.traitCollection = traitCollection
    }

    /// Returns a scaled base value for the given trait colletion.
    /// - Parameter traitCollection: the trait collection
    /// - Returns: a scaled value
    func scaledValue(for traitCollection: UITraitCollection?) -> Value {
        Value(self.metrics.scaledValue(for: CGFloat(self.baseValue), compatibleWith: traitCollection ?? UITraitCollection.current))
    }
}
