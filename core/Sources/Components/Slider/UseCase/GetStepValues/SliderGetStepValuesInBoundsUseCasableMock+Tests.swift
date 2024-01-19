//
//  SliderGetStepValuesInBoundsUseCaseMock.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 02/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

final class SliderGetStepValuesInBoundsUseCasableMock<U>: SparkCore.SliderGetStepValuesInBoundsUseCasable where U: BinaryFloatingPoint, U.Stride: BinaryFloatingPoint {

    // MARK: - Initialization

    init() {}

    // MARK: - execute<V>


    var executeWithBoundsAndStepCallsCount = 0
    var executeWithBoundsAndStepCalled: Bool {
        return executeWithBoundsAndStepCallsCount > 0
    }
    var executeWithBoundsAndStepReceivedArguments: (bounds: ClosedRange<U>, step: U.Stride)?
    var executeWithBoundsAndStepReceivedInvocations: [(bounds: ClosedRange<U>, step: U.Stride)] = []
    var executeWithBoundsAndStepReturnValue: [U]!
    var _executeWithBoundsAndStep: ((ClosedRange<U>, U.Stride) -> Any?)?

    func execute<V>(bounds: ClosedRange<V>, step: V.Stride) -> [V] where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
        guard let castedBounds = bounds as? ClosedRange<U>,
              let castedStep = step as? U.Stride else { 
            fatalError("\(U.self) is not equal to \(V.self)")
        }
        executeWithBoundsAndStepCallsCount += 1
        executeWithBoundsAndStepReceivedArguments = (bounds: castedBounds, step: castedStep)
        executeWithBoundsAndStepReceivedInvocations.append((bounds: castedBounds, step: castedStep))
        return (_executeWithBoundsAndStep.map({  $0(castedBounds, castedStep) }) ?? executeWithBoundsAndStepReturnValue) as! [V]
    }

    // MARK: Reset

    func reset() {
        executeWithBoundsAndStepCallsCount = 0
        executeWithBoundsAndStepReceivedArguments = nil
        executeWithBoundsAndStepReceivedInvocations = []
    }
}
