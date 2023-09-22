//
//  IntentAndVariantSnapshotTests.swift
//  Spark
//
//  Created by michael.zimmermann on 22.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

/// This class supports testing of all permutations of all cases of two enums.
struct IntentAndVariantSnapshotTests<Intent, Variant> where Intent: CaseIterable, Variant: CaseIterable {

    let intent: Intent
    let variant: Variant

    func testName(on function: String = #function) -> String {
        return "\(function)-\(self.intent)-\(self.variant)"
    }

    static var allCases: [Self] {
        return Intent.allCases.flatMap { intent in
            Variant.allCases.map { variant in
                    .init(intent: intent, variant: variant)
            }
        }
    }
}
