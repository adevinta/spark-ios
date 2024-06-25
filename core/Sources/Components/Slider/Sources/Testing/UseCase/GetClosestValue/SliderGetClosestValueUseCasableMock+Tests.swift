//
//  File.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 02/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

// swiftlint:disable force_cast
final class SliderGetClosestValueUseCasableMock<U>: SparkCore.SliderGetClosestValueUseCasable where U: BinaryFloatingPoint {

    // MARK: - Initialization

    init() {}

    // MARK: - execute<V>

    var executeWithValueAndValuesCallsCount = 0
    var executeWithValueAndValuesCalled: Bool {
        return executeWithValueAndValuesCallsCount > 0
    }
    var executeWithValueAndValuesReceivedArguments: (value: U, values: [U])?
    var executeWithValueAndValuesReceivedInvocations: [(value: U, values: [U])] = []
    var executeWithValueAndValuesReturnValue: U!
    var _executeWithValueAndValues: ((U, [U]) -> U?)?

    func execute<V>(value: V, in values: [V]) -> V where V: BinaryFloatingPoint {
        guard let castedValue = value as? U,
              let castedValues = values as? [U] else {
            fatalError("\(U.self) is not equal to \(V.self)")
        }
        executeWithValueAndValuesCallsCount += 1
        executeWithValueAndValuesReceivedArguments = (value: castedValue, values: castedValues)
        executeWithValueAndValuesReceivedInvocations.append((value: castedValue, values: castedValues))
        return (_executeWithValueAndValues.map{ $0(castedValue, castedValues) } ?? executeWithValueAndValuesReturnValue) as! V
    }

    // MARK: Reset

    func reset() {
        executeWithValueAndValuesCallsCount = 0
        executeWithValueAndValuesReceivedArguments = nil
        executeWithValueAndValuesReceivedInvocations = []
    }
}
